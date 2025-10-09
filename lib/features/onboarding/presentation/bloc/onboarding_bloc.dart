import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/user_profile.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState(
    userProfile: const UserProfile(),
    currentStep: 0,
  )) {
    on<OnboardingStarted>(_onOnboardingStarted);
    on<SexSelected>(_onSexSelected);
    on<BirthDateSelected>(_onBirthDateSelected);
    on<HeightSelected>(_onHeightSelected);
    on<WeightSelected>(_onWeightSelected);
    on<BodyFatLevelSelected>(_onBodyFatLevelSelected);
    on<ExpenditureCalculated>(_onExpenditureCalculated);
    on<GoalSet>(_onGoalSet);
    on<DietPreferenceSelected>(_onDietPreferenceSelected);
    on<OnboardingCompleted>(_onOnboardingCompleted);
    on<OnboardingStepChanged>(_onOnboardingStepChanged);
  }

  void _onOnboardingStarted(OnboardingStarted event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentStep: 0));
  }

  void _onSexSelected(SexSelected event, Emitter<OnboardingState> emit) {
    final updatedProfile = state.userProfile.copyWith(sex: event.sex);
    emit(state.copyWith(userProfile: updatedProfile));
  }

  void _onBirthDateSelected(BirthDateSelected event, Emitter<OnboardingState> emit) {
    final updatedProfile = state.userProfile.copyWith(birthDate: event.birthDate);
    emit(state.copyWith(userProfile: updatedProfile));
  }

  void _onHeightSelected(HeightSelected event, Emitter<OnboardingState> emit) {
    final updatedProfile = state.userProfile.copyWith(
      height: event.height,
      heightUnit: event.unit,
    );
    emit(state.copyWith(userProfile: updatedProfile));
  }

  void _onWeightSelected(WeightSelected event, Emitter<OnboardingState> emit) {
    final updatedProfile = state.userProfile.copyWith(
      weight: event.weight,
      weightUnit: event.unit,
    );
    emit(state.copyWith(userProfile: updatedProfile));
  }

  void _onBodyFatLevelSelected(BodyFatLevelSelected event, Emitter<OnboardingState> emit) {
    final updatedProfile = state.userProfile.copyWith(bodyFatLevel: event.bodyFatLevel);
    emit(state.copyWith(userProfile: updatedProfile));
  }

  void _onExpenditureCalculated(ExpenditureCalculated event, Emitter<OnboardingState> emit) {
    final updatedProfile = state.userProfile.copyWith(estimatedExpenditure: event.expenditure);
    emit(state.copyWith(userProfile: updatedProfile));
  }

  void _onGoalSet(GoalSet event, Emitter<OnboardingState> emit) {
    final updatedProfile = state.userProfile.copyWith(
      targetWeight: event.targetWeight,
      goalRatePerWeek: event.goalRatePerWeek,
    );
    emit(state.copyWith(userProfile: updatedProfile));
  }

  void _onDietPreferenceSelected(DietPreferenceSelected event, Emitter<OnboardingState> emit) {
    final updatedProfile = state.userProfile.copyWith(dietPreference: event.dietPreference);
    emit(state.copyWith(userProfile: updatedProfile));
  }

  void _onOnboardingCompleted(OnboardingCompleted event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(isLoading: true));
    // Here you would typically save the profile to local storage or send to server
    emit(state.copyWith(isLoading: false));
  }

  void _onOnboardingStepChanged(OnboardingStepChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentStep: event.step));
  }

  // Helper method to calculate expenditure based on user data
  double calculateExpenditure() {
    final profile = state.userProfile;
    if (profile.sex == null || profile.age == 0 || profile.heightInCm == 0 || profile.weightInKg == 0) {
      return 0;
    }

    // Using Mifflin-St Jeor Equation
    double bmr;
    if (profile.sex == Sex.male) {
      bmr = (10 * profile.weightInKg) + (6.25 * profile.heightInCm) - (5 * profile.age) + 5;
    } else {
      bmr = (10 * profile.weightInKg) + (6.25 * profile.heightInCm) - (5 * profile.age) - 161;
    }

    // Activity factor (assuming sedentary for initial calculation)
    const double activityFactor = 1.2;
    return bmr * activityFactor;
  }

  // Helper method to calculate daily calorie budget
  double calculateDailyCalorieBudget() {
    final expenditure = state.userProfile.estimatedExpenditure ?? 0;
    final goalRate = state.userProfile.goalRatePerWeek ?? 0;
    
    if (expenditure == 0 || goalRate == 0) return expenditure;
    
    // 1 kg of fat = approximately 7700 calories
    // Weekly deficit = goalRate * 7700
    // Daily deficit = (goalRate * 7700) / 7
    final dailyDeficit = (goalRate * 7700) / 7;
    
    return expenditure - dailyDeficit;
  }

  // Helper method to calculate projected end date
  DateTime calculateProjectedEndDate() {
    final currentWeight = state.userProfile.weightInKg;
    final targetWeight = state.userProfile.targetWeight ?? 0;
    final goalRate = state.userProfile.goalRatePerWeek ?? 0;
    
    if (currentWeight == 0 || targetWeight == 0 || goalRate == 0) {
      return DateTime.now().add(const Duration(days: 365));
    }
    
    final weightToLose = (currentWeight - targetWeight).abs();
    final weeksNeeded = (weightToLose / goalRate).ceil();
    
    return DateTime.now().add(Duration(days: weeksNeeded * 7));
  }
}
