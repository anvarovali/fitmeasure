import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../../features/onboarding/domain/models/user_profile.dart';

class ProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isCompleted = index < currentStep;
        final isCurrent = index == currentStep;
        
        return Expanded(
          child: Container(
            height: 2,
            margin: EdgeInsets.only(
              right: index < totalSteps - 1 ? 4 : 0,
            ),
            decoration: BoxDecoration(
              color: isCompleted || isCurrent 
                  ? AppTheme.textPrimary 
                  : AppTheme.textTertiary,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        );
      }),
    );
  }
}

class OnboardingHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final int currentStep;
  final int totalSteps;

  const OnboardingHeader({
    super.key,
    required this.title,
    this.onBack,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (onBack != null)
              IconButton(
                onPressed: onBack,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppTheme.textPrimary,
                ),
              ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            if (onBack != null)
              const SizedBox(width: 48), // Balance the back button
          ],
        ),
        const SizedBox(height: 16),
        ProgressIndicator(
          currentStep: currentStep,
          totalSteps: totalSteps,
        ),
      ],
    );
  }
}

class SelectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          border: isSelected 
              ? Border.all(color: AppTheme.textPrimary, width: 2)
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isSelected ? AppTheme.textPrimary : AppTheme.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.textPrimary : AppTheme.secondaryDark,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    icon!,
                    style: TextStyle(
                      fontSize: 20,
                      color: isSelected ? AppTheme.primaryDark : AppTheme.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
            if (isSelected) ...[
              const SizedBox(width: 12),
              const Icon(
                Icons.check,
                color: AppTheme.textPrimary,
                size: 24,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class UnitSelector extends StatelessWidget {
  final String leftOption;
  final String rightOption;
  final bool isLeftSelected;
  final ValueChanged<bool> onChanged;

  const UnitSelector({
    super.key,
    required this.leftOption,
    required this.rightOption,
    required this.isLeftSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(true),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: isLeftSelected ? AppTheme.textPrimary : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    leftOption,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isLeftSelected ? AppTheme.primaryDark : AppTheme.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(false),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: !isLeftSelected ? AppTheme.textPrimary : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    rightOption,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: !isLeftSelected ? AppTheme.primaryDark : AppTheme.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;
  final String Function(double) labelBuilder;

  const CustomSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          labelBuilder(value),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 24),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppTheme.accentGreen,
            inactiveTrackColor: AppTheme.textTertiary,
            thumbColor: AppTheme.accentGreen,
            overlayColor: AppTheme.accentGreen.withOpacity(0.2),
            trackHeight: 4,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelBuilder(min),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              labelBuilder(max),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}

class BodyFatGrid extends StatelessWidget {
  final List<BodyFatOption> options;
  final dynamic selectedLevel; // Changed to dynamic to match the model
  final ValueChanged<dynamic> onSelected;

  const BodyFatGrid({
    super.key,
    required this.options,
    this.selectedLevel,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = selectedLevel == option.level;
        
        return GestureDetector(
          onTap: () => onSelected(option.level),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.secondaryDark,
              borderRadius: BorderRadius.circular(12),
              border: isSelected 
                  ? Border.all(color: AppTheme.textPrimary, width: 2)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Placeholder for body illustration
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.textTertiary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppTheme.textSecondary,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  option.range,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected ? AppTheme.textPrimary : AppTheme.textPrimary,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(height: 4),
                  const Icon(
                    Icons.check,
                    color: AppTheme.textPrimary,
                    size: 16,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

