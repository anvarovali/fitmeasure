import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/user_profile.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../../../../core/widgets/onboarding_widgets.dart';
import '../../../../core/theme/app_theme.dart';

class DietPreferencePage extends StatefulWidget {
  const DietPreferencePage({super.key});

  @override
  State<DietPreferencePage> createState() => _DietPreferencePageState();
}

class _DietPreferencePageState extends State<DietPreferencePage> {
  @override
  void initState() {
    super.initState();
    // Set the current step to 7 (diet preference)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingBloc>().add(const OnboardingStepChanged(7));
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
                    title: 'Set New Program',
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
                          'What is your preferred diet?',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 32),
                        Expanded(
                          child: ListView.builder(
                            itemCount: DietOption.options.length,
                            itemBuilder: (context, index) {
                              final option = DietOption.options[index];
                              final isSelected = state.userProfile.dietPreference == option.preference;
                              
                              return SelectionCard(
                                title: option.title,
                                subtitle: option.description,
                                icon: option.icon,
                                isSelected: isSelected,
                                onTap: () {
                                  context.read<OnboardingBloc>().add(
                                    DietPreferenceSelected(option.preference),
                                  );
                                },
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
                              // Navigate to sign-in page
                              context.push('/onboarding/signin');
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
