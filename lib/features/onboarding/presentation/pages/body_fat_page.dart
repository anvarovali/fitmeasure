import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/user_profile.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../../../../core/widgets/onboarding_widgets.dart';
import '../../../../core/theme/app_theme.dart';

class BodyFatPage extends StatefulWidget {
  const BodyFatPage({super.key});

  @override
  State<BodyFatPage> createState() => _BodyFatPageState();
}

class _BodyFatPageState extends State<BodyFatPage> {
  @override
  void initState() {
    super.initState();
    // Set the current step to 4 (body fat)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingBloc>().add(const OnboardingStepChanged(4));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            final options = state.userProfile.sex == Sex.male 
                ? BodyFatOption.maleOptions 
                : BodyFatOption.femaleOptions;

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
                          'What is your body fat level?',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Don\'t worry about being too precise. A visual assessment is sufficient.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Expanded(
                          child: BodyFatGrid(
                            options: options,
                            selectedLevel: state.userProfile.bodyFatLevel,
                            onSelected: (level) {
                              context.read<OnboardingBloc>().add(
                                BodyFatLevelSelected(level),
                              );
                            },
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
                              // Calculate expenditure and navigate to expenditure page
                              final bloc = context.read<OnboardingBloc>();
                              final expenditure = bloc.calculateExpenditure();
                              bloc.add(ExpenditureCalculated(expenditure));
                              context.push('/onboarding/expenditure');
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
