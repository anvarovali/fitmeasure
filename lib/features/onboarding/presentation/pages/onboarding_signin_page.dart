import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingSignInPage extends StatefulWidget {
  const OnboardingSignInPage({super.key});

  @override
  State<OnboardingSignInPage> createState() => _OnboardingSignInPageState();
}

class _OnboardingSignInPageState extends State<OnboardingSignInPage> {
  @override
  void initState() {
    super.initState();
    // Set the current step to 8 (sign in)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingBloc>().add(const OnboardingStepChanged(8));
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
                  // Header without progress bar
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Set the step back to 7 (diet preference) before going back
                          context.read<OnboardingBloc>().add(const OnboardingStepChanged(7));
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Create Account',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 48), // Balance the back button
                    ],
                  ),
                  const SizedBox(height: 48),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign in to save your progress',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your profile and preferences will be saved to your account so you can access them from any device.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        // Authentication Options at bottom
                        Column(
                          children: [
                            _buildAuthButton(
                              context,
                              'Continue with Google',
                              Icons.g_mobiledata,
                              Colors.white,
                              AppTheme.primaryDark,
                              () {
                                _handleGoogleSignIn(context);
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildAuthButton(
                              context,
                              'Continue with Apple',
                              Icons.apple,
                              AppTheme.secondaryDark,
                              AppTheme.textPrimary,
                              () {
                                _handleAppleSignIn(context);
                              },
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildAuthButton(
    BuildContext context,
    String text,
    IconData icon,
    Color backgroundColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: backgroundColor == Colors.white ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: textColor,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleGoogleSignIn(BuildContext context) {
    // TODO: Implement Google Sign In
    _completeOnboarding(context);
  }

  void _handleAppleSignIn(BuildContext context) {
    // TODO: Implement Apple Sign In
    _completeOnboarding(context);
  }

  void _completeOnboarding(BuildContext context) {
    // Complete onboarding and navigate to dashboard
    context.read<OnboardingBloc>().add(const OnboardingCompleted());
    context.go('/dashboard');
  }
}
