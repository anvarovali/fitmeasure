import 'package:equatable/equatable.dart';

enum Sex { male, female }

enum HeightUnit { feetInches, centimeters }

enum WeightUnit { pounds, kilograms }

enum BodyFatLevel {
  veryLow, // 3-4%
  low, // 5-7%
  moderate, // 8-12%
  average, // 13-17%
  aboveAverage, // 18-23%
  high, // 24-29%
  veryHigh, // 30-34%
  extremelyHigh, // 35-39%
  critical, // 40%+
}

enum DietPreference {
  balanced,
  lowFat,
  lowCarb,
  keto,
}

class UserProfile extends Equatable {
  final Sex? sex;
  final DateTime? birthDate;
  final double? height;
  final HeightUnit? heightUnit;
  final double? weight;
  final WeightUnit? weightUnit;
  final BodyFatLevel? bodyFatLevel;
  final double? estimatedExpenditure;
  final double? targetWeight;
  final double? goalRatePerWeek; // kg per week
  final DietPreference? dietPreference;
  final double? dailyCalorieBudget;
  final DateTime? projectedEndDate;

  const UserProfile({
    this.sex,
    this.birthDate,
    this.height,
    this.heightUnit,
    this.weight,
    this.weightUnit,
    this.bodyFatLevel,
    this.estimatedExpenditure,
    this.targetWeight,
    this.goalRatePerWeek,
    this.dietPreference,
    this.dailyCalorieBudget,
    this.projectedEndDate,
  });

  UserProfile copyWith({
    Sex? sex,
    DateTime? birthDate,
    double? height,
    HeightUnit? heightUnit,
    double? weight,
    WeightUnit? weightUnit,
    BodyFatLevel? bodyFatLevel,
    double? estimatedExpenditure,
    double? targetWeight,
    double? goalRatePerWeek,
    DietPreference? dietPreference,
    double? dailyCalorieBudget,
    DateTime? projectedEndDate,
  }) {
    return UserProfile(
      sex: sex ?? this.sex,
      birthDate: birthDate ?? this.birthDate,
      height: height ?? this.height,
      heightUnit: heightUnit ?? this.heightUnit,
      weight: weight ?? this.weight,
      weightUnit: weightUnit ?? this.weightUnit,
      bodyFatLevel: bodyFatLevel ?? this.bodyFatLevel,
      estimatedExpenditure: estimatedExpenditure ?? this.estimatedExpenditure,
      targetWeight: targetWeight ?? this.targetWeight,
      goalRatePerWeek: goalRatePerWeek ?? this.goalRatePerWeek,
      dietPreference: dietPreference ?? this.dietPreference,
      dailyCalorieBudget: dailyCalorieBudget ?? this.dailyCalorieBudget,
      projectedEndDate: projectedEndDate ?? this.projectedEndDate,
    );
  }

  int get age {
    if (birthDate == null) return 0;
    final now = DateTime.now();
    int age = now.year - birthDate!.year;
    if (now.month < birthDate!.month || 
        (now.month == birthDate!.month && now.day < birthDate!.day)) {
      age--;
    }
    return age;
  }

  double get heightInCm {
    if (height == null || heightUnit == null) return 0;
    if (heightUnit == HeightUnit.centimeters) {
      return height!;
    } else {
      // Convert feet and inches to cm
      // Assuming height is stored as total inches
      return height! * 2.54;
    }
  }

  double get weightInKg {
    if (weight == null || weightUnit == null) return 0;
    if (weightUnit == WeightUnit.kilograms) {
      return weight!;
    } else {
      // Convert pounds to kg
      return weight! * 0.453592;
    }
  }

  double get bmi {
    final heightM = heightInCm / 100;
    if (heightM == 0) return 0;
    return weightInKg / (heightM * heightM);
  }

  @override
  List<Object?> get props => [
        sex,
        birthDate,
        height,
        heightUnit,
        weight,
        weightUnit,
        bodyFatLevel,
        estimatedExpenditure,
        targetWeight,
        goalRatePerWeek,
        dietPreference,
        dailyCalorieBudget,
        projectedEndDate,
      ];
}

class BodyFatOption {
  final BodyFatLevel level;
  final String range;
  final String description;

  const BodyFatOption({
    required this.level,
    required this.range,
    required this.description,
  });

  static const List<BodyFatOption> maleOptions = [
    BodyFatOption(
      level: BodyFatLevel.veryLow,
      range: '3-4%',
      description: 'Essential fat',
    ),
    BodyFatOption(
      level: BodyFatLevel.low,
      range: '5-7%',
      description: 'Athletes',
    ),
    BodyFatOption(
      level: BodyFatLevel.moderate,
      range: '8-12%',
      description: 'Fitness',
    ),
    BodyFatOption(
      level: BodyFatLevel.average,
      range: '13-17%',
      description: 'Acceptable',
    ),
    BodyFatOption(
      level: BodyFatLevel.aboveAverage,
      range: '18-23%',
      description: 'Average',
    ),
    BodyFatOption(
      level: BodyFatLevel.high,
      range: '24-29%',
      description: 'Above average',
    ),
    BodyFatOption(
      level: BodyFatLevel.veryHigh,
      range: '30-34%',
      description: 'Overweight',
    ),
    BodyFatOption(
      level: BodyFatLevel.extremelyHigh,
      range: '35-39%',
      description: 'Obese',
    ),
    BodyFatOption(
      level: BodyFatLevel.critical,
      range: '40%+',
      description: 'Morbidly obese',
    ),
  ];

  static const List<BodyFatOption> femaleOptions = [
    BodyFatOption(
      level: BodyFatLevel.veryLow,
      range: '8-10%',
      description: 'Essential fat',
    ),
    BodyFatOption(
      level: BodyFatLevel.low,
      range: '11-13%',
      description: 'Athletes',
    ),
    BodyFatOption(
      level: BodyFatLevel.moderate,
      range: '14-17%',
      description: 'Fitness',
    ),
    BodyFatOption(
      level: BodyFatLevel.average,
      range: '18-22%',
      description: 'Acceptable',
    ),
    BodyFatOption(
      level: BodyFatLevel.aboveAverage,
      range: '23-27%',
      description: 'Average',
    ),
    BodyFatOption(
      level: BodyFatLevel.high,
      range: '28-32%',
      description: 'Above average',
    ),
    BodyFatOption(
      level: BodyFatLevel.veryHigh,
      range: '33-37%',
      description: 'Overweight',
    ),
    BodyFatOption(
      level: BodyFatLevel.extremelyHigh,
      range: '38-42%',
      description: 'Obese',
    ),
    BodyFatOption(
      level: BodyFatLevel.critical,
      range: '43%+',
      description: 'Morbidly obese',
    ),
  ];
}

class DietOption {
  final DietPreference preference;
  final String title;
  final String description;
  final String icon;

  const DietOption({
    required this.preference,
    required this.title,
    required this.description,
    required this.icon,
  });

  static const List<DietOption> options = [
    DietOption(
      preference: DietPreference.balanced,
      title: 'Balanced',
      description: 'Standard distribution of carbs and fat.',
      icon: '⚖️',
    ),
    DietOption(
      preference: DietPreference.lowFat,
      title: 'Low-fat',
      description: 'Fat will be reduced to prioritize carb and protein intake.',
      icon: '🥗',
    ),
    DietOption(
      preference: DietPreference.lowCarb,
      title: 'Low-carb',
      description: 'Carbs will be reduced to prioritize fat and protein intake.',
      icon: '🥩',
    ),
    DietOption(
      preference: DietPreference.keto,
      title: 'Keto',
      description: 'Carbs will be very restricted to allow for higher fat intake.',
      icon: '🥑',
    ),
  ];
}
