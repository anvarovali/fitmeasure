import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../../../../core/widgets/onboarding_widgets.dart';
import '../../../../core/theme/app_theme.dart';

class BirthDatePage extends StatefulWidget {
  const BirthDatePage({super.key});

  @override
  State<BirthDatePage> createState() => _BirthDatePageState();
}

class _BirthDatePageState extends State<BirthDatePage> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now().subtract(const Duration(days: 365 * 25)); // Default to 25 years ago
    // Send initial date to bloc and set current step
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingBloc>().add(const OnboardingStepChanged(1));
      context.read<OnboardingBloc>().add(
        BirthDateSelected(selectedDate),
      );
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
                          'When were you born?',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 48),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              height: 200,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: selectedDate,
                                maximumDate: DateTime.now(),
                                minimumDate: DateTime(1900),
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(() {
                                    selectedDate = newDate;
                                  });
                                  context.read<OnboardingBloc>().add(
                                    BirthDateSelected(newDate),
                                  );
                                },
                              ),
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
                              context.push('/onboarding/height');
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
}
