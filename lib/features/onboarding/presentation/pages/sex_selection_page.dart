import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/user_profile.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../../../../core/widgets/onboarding_widgets.dart';
import '../../../../core/theme/app_theme.dart';

class SexSelectionPage extends StatefulWidget {
  const SexSelectionPage({super.key});

  @override
  State<SexSelectionPage> createState() => _SexSelectionPageState();
}

class _SexSelectionPageState extends State<SexSelectionPage> {
  @override
  void initState() {
    super.initState();
    // Set the current step to 0 (sex selection)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingBloc>().add(const OnboardingStepChanged(0));
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
                    onBack: () => context.go('/'),
                    currentStep: state.currentStep,
                    totalSteps: 9,
                  ),
                  const SizedBox(height: 48),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What is your sex?',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 32),
                        SelectionCard(
                          title: 'Female',
                          icon: '♀',
                          isSelected: state.userProfile.sex == Sex.female,
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                              const SexSelected(Sex.female),
                            );
                          },
                        ),
                        SelectionCard(
                          title: 'Male',
                          icon: '♂',
                          isSelected: state.userProfile.sex == Sex.male,
                          onTap: () {
                            context.read<OnboardingBloc>().add(
                              const SexSelected(Sex.male),
                            );
                          },
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
                              // Navigate to next page
                              context.push('/onboarding/birth-date');
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
