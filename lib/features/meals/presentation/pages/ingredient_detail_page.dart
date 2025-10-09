import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/ingredient.dart';
import '../../data/meals_service.dart';

class IngredientDetailPage extends StatefulWidget {
  final String ingredientId;

  const IngredientDetailPage({
    super.key,
    required this.ingredientId,
  });

  @override
  State<IngredientDetailPage> createState() => _IngredientDetailPageState();
}

class _IngredientDetailPageState extends State<IngredientDetailPage> {
  double _amount = 100.0; // Default amount in grams

  @override
  Widget build(BuildContext context) {
    final ingredient = MealsService.getIngredientById(widget.ingredientId);
    
    if (ingredient == null) {
      return Scaffold(
        backgroundColor: AppTheme.primaryDark,
        appBar: AppBar(
          backgroundColor: AppTheme.primaryDark,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Ingredient Not Found',
            style: TextStyle(color: AppTheme.textPrimary),
          ),
        ),
        body: const Center(
          child: Text(
            'Ingredient not found',
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ),
      );
    }

    final macros = ingredient.getMacrosForAmount(_amount);

    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          ingredient.name,
          style: const TextStyle(color: AppTheme.textPrimary),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: AppTheme.textPrimary),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ingredient Image Placeholder
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
              ),
              child: Icon(
                _getIngredientIcon(ingredient.category),
                size: 64,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            
            // Ingredient Title and Description
            Text(
              ingredient.name,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              ingredient.description,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.accentBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.accentBlue.withOpacity(0.3)),
              ),
              child: Text(
                ingredient.category.displayName,
                style: const TextStyle(
                  color: AppTheme.accentBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Amount Selector
            _buildSection(
              'Amount',
              _buildAmountSelector(),
            ),
            const SizedBox(height: 24),
            
            // Nutritional Information
            _buildSection(
              'Nutritional Information',
              _buildNutritionGrid(macros),
            ),
            const SizedBox(height: 24),
            
            // Dietary Information
            _buildSection(
              'Dietary Information',
              _buildDietaryInfo(ingredient),
            ),
            const SizedBox(height: 24),
            
            // Allergen Information
            if (ingredient.allergens.isNotEmpty)
              _buildSection(
                'Allergens',
                _buildAllergenInfo(ingredient.allergens),
              ),
            if (ingredient.allergens.isNotEmpty) const SizedBox(height: 24),
            
            // Add to Meal Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added ${ingredient.name} (${_amount.toInt()}g) to meal'),
                      backgroundColor: AppTheme.accentGreen,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentGreen,
                  foregroundColor: AppTheme.textPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add to Meal',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildAmountSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount: ${_amount.toInt()}g',
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Per 100g: ${MealsService.getIngredientById(widget.ingredientId)!.caloriesPer100g.toInt()} cal',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            value: _amount,
            min: 1.0,
            max: 1000.0,
            divisions: 999,
            activeColor: AppTheme.accentGreen,
            inactiveColor: AppTheme.textTertiary,
            onChanged: (value) {
              setState(() {
                _amount = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1g',
                style: TextStyle(
                  color: AppTheme.textTertiary,
                  fontSize: 12,
                ),
              ),
              Text(
                '1000g',
                style: TextStyle(
                  color: AppTheme.textTertiary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionGrid(Map<String, double> macros) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNutritionItem('Calories', '${macros['calories']!.toInt()}', AppTheme.accentRed),
              _buildNutritionItem('Protein', '${macros['protein']!.toStringAsFixed(1)}g', AppTheme.accentGreen),
              _buildNutritionItem('Carbs', '${macros['carbs']!.toStringAsFixed(1)}g', AppTheme.accentBlue),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNutritionItem('Fat', '${macros['fat']!.toStringAsFixed(1)}g', AppTheme.accentYellow),
              _buildNutritionItem('Fiber', '${macros['fiber']!.toStringAsFixed(1)}g', AppTheme.accentPurple),
              _buildNutritionItem('Sugar', '${macros['sugar']!.toStringAsFixed(1)}g', AppTheme.accentRed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDietaryInfo(Ingredient ingredient) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          _buildDietaryItem('Vegan', ingredient.isVegan),
          _buildDietaryItem('Vegetarian', ingredient.isVegetarian),
          _buildDietaryItem('Gluten Free', ingredient.isGlutenFree),
        ],
      ),
    );
  }

  Widget _buildDietaryItem(String label, bool isTrue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isTrue ? Icons.check_circle : Icons.cancel,
            color: isTrue ? AppTheme.accentGreen : AppTheme.accentRed,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergenInfo(List<String> allergens) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
      ),
      child: Column(
        children: allergens.map((allergen) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: AppTheme.accentRed,
                  size: 16,
                ),
                const SizedBox(width: 12),
                Text(
                  allergen,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getIngredientIcon(IngredientCategory category) {
    switch (category) {
      case IngredientCategory.protein:
        return Icons.fitness_center;
      case IngredientCategory.carbs:
        return Icons.grain;
      case IngredientCategory.fats:
        return Icons.opacity;
      case IngredientCategory.vegetables:
        return Icons.eco;
      case IngredientCategory.fruits:
        return Icons.apple;
      case IngredientCategory.dairy:
        return Icons.local_drink;
      case IngredientCategory.grains:
        return Icons.grain;
      case IngredientCategory.nuts:
        return Icons.circle;
      case IngredientCategory.spices:
        return Icons.local_fire_department;
      case IngredientCategory.other:
        return Icons.category;
    }
  }
}
