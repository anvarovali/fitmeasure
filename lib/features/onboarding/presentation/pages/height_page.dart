import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/user_profile.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../../../../core/widgets/onboarding_widgets.dart';
import '../../../../core/theme/app_theme.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({super.key});

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  bool isFeetInches = true;
  double heightInFeet = 5.0;
  double heightInInches = 8.0;
  double heightInCm = 170.0;

  @override
  void initState() {
    super.initState();
    // Send initial height to bloc and set current step
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingBloc>().add(const OnboardingStepChanged(2));
      _updateHeight();
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
                          'What is your height?',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 32),
                        UnitSelector(
                          leftOption: 'Feet and Inches',
                          rightOption: 'Centimeters',
                          isLeftSelected: isFeetInches,
                          onChanged: (isLeft) {
                            setState(() {
                              isFeetInches = isLeft;
                            });
                            _updateHeight();
                          },
                        ),
                        const SizedBox(height: 48),
                        Expanded(
                          child: Center(
                            child: isFeetInches
                                ? _buildFeetInchesPicker()
                                : _buildCentimetersPicker(),
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
                              context.push('/onboarding/weight');
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

  Widget _buildFeetInchesPicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${heightInFeet.toInt()} ft ${heightInInches.toInt()} in',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Feet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          heightInFeet = 3.0 + index;
                        });
                        _updateHeight();
                      },
                      children: List.generate(5, (index) {
                        final feet = 3 + index;
                        return Center(
                          child: Text(
                            '$feet ft',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Inches',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          heightInInches = index.toDouble();
                        });
                        _updateHeight();
                      },
                      children: List.generate(12, (index) {
                        return Center(
                          child: Text(
                            '$index in',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCentimetersPicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${heightInCm.toInt()} cm',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              setState(() {
                heightInCm = 100.0 + index;
              });
              _updateHeight();
            },
            children: List.generate(101, (index) {
              final cm = 100 + index;
              return Center(
                child: Text(
                  '$cm cm',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _updateHeight() {
    double height;
    HeightUnit unit;
    
    if (isFeetInches) {
      height = heightInFeet * 12 + heightInInches; // Convert to total inches
      unit = HeightUnit.feetInches;
    } else {
      height = heightInCm;
      unit = HeightUnit.centimeters;
    }
    
    context.read<OnboardingBloc>().add(
      HeightSelected(height, unit),
    );
  }
}
