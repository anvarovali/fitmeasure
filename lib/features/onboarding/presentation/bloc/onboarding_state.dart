import 'package:equatable/equatable.dart';
import '../../domain/models/user_profile.dart';

class OnboardingState extends Equatable {
  final UserProfile userProfile;
  final int currentStep;
  final bool isLoading;
  final String? error;

  const OnboardingState({
    required this.userProfile,
    required this.currentStep,
    this.isLoading = false,
    this.error,
  });

  OnboardingState copyWith({
    UserProfile? userProfile,
    int? currentStep,
    bool? isLoading,
    String? error,
  }) {
    return OnboardingState(
      userProfile: userProfile ?? this.userProfile,
      currentStep: currentStep ?? this.currentStep,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get canProceed {
    switch (currentStep) {
      case 0: // Sex selection
        return userProfile.sex != null;
      case 1: // Birth date
        return userProfile.birthDate != null;
      case 2: // Height
        return userProfile.height != null && userProfile.heightUnit != null;
      case 3: // Weight
        return userProfile.weight != null && userProfile.weightUnit != null;
      case 4: // Body fat level
        return userProfile.bodyFatLevel != null;
      case 5: // Expenditure (calculated automatically)
        return userProfile.estimatedExpenditure != null;
      case 6: // Goal setting
        return userProfile.targetWeight != null && userProfile.goalRatePerWeek != null;
      case 7: // Diet preference
        return userProfile.dietPreference != null;
      case 8: // Sign in (always can proceed)
        return true;
      default:
        return false;
    }
  }

  bool get isCompleted {
    return userProfile.sex != null &&
        userProfile.birthDate != null &&
        userProfile.height != null &&
        userProfile.heightUnit != null &&
        userProfile.weight != null &&
        userProfile.weightUnit != null &&
        userProfile.bodyFatLevel != null &&
        userProfile.estimatedExpenditure != null &&
        userProfile.targetWeight != null &&
        userProfile.goalRatePerWeek != null &&
        userProfile.dietPreference != null;
  }

  @override
  List<Object?> get props => [userProfile, currentStep, isLoading, error];
}
