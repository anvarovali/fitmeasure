import 'package:equatable/equatable.dart';
import '../../domain/models/user_profile.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class OnboardingStarted extends OnboardingEvent {
  const OnboardingStarted();
}

class SexSelected extends OnboardingEvent {
  final Sex sex;

  const SexSelected(this.sex);

  @override
  List<Object?> get props => [sex];
}

class BirthDateSelected extends OnboardingEvent {
  final DateTime birthDate;

  const BirthDateSelected(this.birthDate);

  @override
  List<Object?> get props => [birthDate];
}

class HeightSelected extends OnboardingEvent {
  final double height;
  final HeightUnit unit;

  const HeightSelected(this.height, this.unit);

  @override
  List<Object?> get props => [height, unit];
}

class WeightSelected extends OnboardingEvent {
  final double weight;
  final WeightUnit unit;

  const WeightSelected(this.weight, this.unit);

  @override
  List<Object?> get props => [weight, unit];
}

class BodyFatLevelSelected extends OnboardingEvent {
  final BodyFatLevel bodyFatLevel;

  const BodyFatLevelSelected(this.bodyFatLevel);

  @override
  List<Object?> get props => [bodyFatLevel];
}

class ExpenditureCalculated extends OnboardingEvent {
  final double expenditure;

  const ExpenditureCalculated(this.expenditure);

  @override
  List<Object?> get props => [expenditure];
}

class GoalSet extends OnboardingEvent {
  final double targetWeight;
  final double goalRatePerWeek;

  const GoalSet(this.targetWeight, this.goalRatePerWeek);

  @override
  List<Object?> get props => [targetWeight, goalRatePerWeek];
}

class DietPreferenceSelected extends OnboardingEvent {
  final DietPreference dietPreference;

  const DietPreferenceSelected(this.dietPreference);

  @override
  List<Object?> get props => [dietPreference];
}

class OnboardingCompleted extends OnboardingEvent {
  const OnboardingCompleted();
}

class OnboardingStepChanged extends OnboardingEvent {
  final int step;

  const OnboardingStepChanged(this.step);

  @override
  List<Object?> get props => [step];
}
