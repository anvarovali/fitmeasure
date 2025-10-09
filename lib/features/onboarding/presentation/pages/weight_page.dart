import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/user_profile.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../../../../core/widgets/onboarding_widgets.dart';
import '../../../../core/theme/app_theme.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  bool isKilograms = true;
  double weightInKg = 70.0;
  double weightInLbs = 154.0;

  @override
  void initState() {
    super.initState();
    // Send initial weight to bloc and set current step
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingBloc>().add(const OnboardingStepChanged(3));
      _updateWeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  OnboardingHeader(
                    title: 'Basics',
                    onBack: () => context.pop(),
                    currentStep: state.currentStep,
                    totalSteps: 9,
                  ),
                  const SizedBox(height: 48),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What is your weight?',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 32),
                        UnitSelector(
                          leftOption: 'Pounds',
                          rightOption: 'Kilograms',
                          isLeftSelected: !isKilograms,
                          onChanged: (isLeft) {
                            setState(() {
                              isKilograms = !isLeft;
                            });
                            _updateWeight();
                          },
                        ),
                        const SizedBox(height: 48),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isKilograms 
                                      ? '${weightInKg.toInt()} kg'
                                      : '${weightInLbs.toInt()} lbs',
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                                const SizedBox(height: 32),
                                _buildWeightSlider(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.canProceed
                          ? () {
                              context.push('/onboarding/body-fat');
                            }
                          : null,
                      child: const Text('Next'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWeightSlider() {
    final min = isKilograms ? 30.0 : 66.0;
    final max = isKilograms ? 200.0 : 440.0;
    final current = isKilograms ? weightInKg : weightInLbs;
    final divisions = isKilograms ? 170 : 374;

    return CustomSlider(
      value: current,
      min: min,
      max: max,
      divisions: divisions,
      onChanged: (value) {
        setState(() {
          if (isKilograms) {
            weightInKg = value;
            weightInLbs = value * 2.20462;
          } else {
            weightInLbs = value;
            weightInKg = value * 0.453592;
          }
        });
        _updateWeight();
      },
      labelBuilder: (value) => isKilograms 
          ? '${value.toInt()} kg'
          : '${value.toInt()} lbs',
    );
  }

  void _updateWeight() {
    final weight = isKilograms ? weightInKg : weightInLbs;
    final unit = isKilograms ? WeightUnit.kilograms : WeightUnit.pounds;
    
    context.read<OnboardingBloc>().add(
      WeightSelected(weight, unit),
    );
  }
}
