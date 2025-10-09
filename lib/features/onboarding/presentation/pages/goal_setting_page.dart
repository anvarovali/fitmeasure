import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../../../../core/widgets/onboarding_widgets.dart';
import '../../../../core/theme/app_theme.dart';

class GoalSettingPage extends StatefulWidget {
  const GoalSettingPage({super.key});

  @override
  State<GoalSettingPage> createState() => _GoalSettingPageState();
}

class _GoalSettingPageState extends State<GoalSettingPage> {
  double targetWeight = 85.0;
  double goalRatePerWeek = 0.5;

  @override
  void initState() {
    super.initState();
    // Set the current step to 6 (goal setting)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingBloc>().add(const OnboardingStepChanged(6));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            final expenditure = state.userProfile.estimatedExpenditure ?? 0;
            final dailyBudget = expenditure - ((goalRatePerWeek * 7700) / 7);
            final projectedEndDate = DateTime.now().add(
              Duration(days: ((state.userProfile.weightInKg - targetWeight).abs() / goalRatePerWeek * 7).ceil()),
            );

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  OnboardingHeader(
                    title: 'Set New Goal',
                    onBack: () => context.pop(),
                    currentStep: state.currentStep,
                    totalSteps: 9,
                  ),
                  const SizedBox(height: 32),
                  // Goal summary cards
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.accentGreen.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.accentGreen.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dailyBudget.toInt()} kcal',
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                'initial daily budget',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${projectedEndDate.day}/${projectedEndDate.month}/${projectedEndDate.year}',
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                'projected end date',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What is your target weight?',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${targetWeight.toInt()} kg',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 16),
                          CustomSlider(
                            value: targetWeight,
                            min: 40.0,
                            max: 150.0,
                            divisions: 110,
                            onChanged: (value) {
                              setState(() {
                                targetWeight = value;
                              });
                            },
                            labelBuilder: (value) => '${value.toInt()} kg',
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'What is your target goal rate?',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.accentGreen.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Standard',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppTheme.accentGreen,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomSlider(
                            value: goalRatePerWeek,
                            min: 0.1,
                            max: 1.0,
                            divisions: 90,
                            onChanged: (value) {
                              setState(() {
                                goalRatePerWeek = value;
                              });
                            },
                            labelBuilder: (value) => '${value.toStringAsFixed(1)} kg/week',
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '- ${goalRatePerWeek.toStringAsFixed(1)} kg',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Text(
                                      'Per Week',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '- ${(goalRatePerWeek * 4.3).toStringAsFixed(1)} kg',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Text(
                                      'Per Month',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<OnboardingBloc>().add(
                          GoalSet(targetWeight, goalRatePerWeek),
                        );
                        context.push('/onboarding/diet-preference');
                      },
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
