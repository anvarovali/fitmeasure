import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/meal.dart';
import '../../domain/models/ingredient.dart';
import '../../data/meals_service.dart';

class CreateMealPage extends StatefulWidget {
  const CreateMealPage({super.key});

  @override
  State<CreateMealPage> createState() => _CreateMealPageState();
}

class _CreateMealPageState extends State<CreateMealPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _servingsController = TextEditingController();

  String _selectedCategory = 'Protein';
  List<String> _selectedIngredients = [];
  List<Ingredient> _availableIngredients = [];

  @override
  void initState() {
    super.initState();
    _availableIngredients = MealsService.getAllIngredients();
    _servingsController.text = '1';
    _prepTimeController.text = '10';
    _cookTimeController.text = '20';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _servingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          'Create Meal',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: _saveMeal,
            child: const Text(
              'Save',
              style: TextStyle(
                color: AppTheme.accentGreen,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Section
              _buildSection(
                'Basic Information',
                [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Meal Name',
                    hint: 'Enter meal name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a meal name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    hint: 'Enter meal description',
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildCategorySelector(),
                ],
              ),
              const SizedBox(height: 24),

              // Time and Servings Section
              _buildSection(
                'Time & Servings',
                [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _prepTimeController,
                          label: 'Prep Time (min)',
                          hint: 'Enter prep time',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Invalid number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: _cookTimeController,
                          label: 'Cook Time (min)',
                          hint: 'Enter cook time',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Invalid number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _servingsController,
                    label: 'Servings',
                    hint: 'Enter number of servings',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of servings';
                      }
                      if (int.tryParse(value) == null || int.parse(value) <= 0) {
                        return 'Enter valid number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Ingredients Section
              _buildSection(
                'Ingredients',
                [
                  _buildIngredientSelector(),
                  const SizedBox(height: 16),
                  _buildSelectedIngredientsList(),
                ],
              ),
              const SizedBox(height: 24),

              // Nutritional Preview
              if (_selectedIngredients.isNotEmpty)
                _buildSection(
                  'Nutritional Preview',
                  [_buildNutritionalPreview()],
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
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
        ...children,
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: AppTheme.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: AppTheme.textSecondary),
        hintStyle: const TextStyle(color: AppTheme.textTertiary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.textTertiary.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.textTertiary.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.textPrimary),
        ),
        filled: true,
        fillColor: AppTheme.secondaryDark,
      ),
    );
  }

  Widget _buildCategorySelector() {
    final categories = ['Protein', 'Vegetarian', 'Breakfast', 'Lunch', 'Dinner', 'Snack'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: categories.map((category) {
            final isSelected = _selectedCategory == category;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.accentGreen : AppTheme.secondaryDark,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppTheme.accentGreen : AppTheme.textTertiary.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? AppTheme.textPrimary : AppTheme.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildIngredientSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Ingredients',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: _availableIngredients.length,
              itemBuilder: (context, index) {
                final ingredient = _availableIngredients[index];
                final isSelected = _selectedIngredients.contains(ingredient.name);
                
                return ListTile(
                  leading: Icon(
                    _getIngredientIcon(ingredient.category),
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                  title: Text(
                    ingredient.name,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    '${ingredient.caloriesPer100g.toInt()} cal/100g',
                    style: const TextStyle(
                      color: AppTheme.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isSelected ? Icons.check_circle : Icons.add_circle_outline,
                      color: isSelected ? AppTheme.accentGreen : AppTheme.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isSelected) {
                          _selectedIngredients.remove(ingredient.name);
                        } else {
                          _selectedIngredients.add(ingredient.name);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedIngredientsList() {
    if (_selectedIngredients.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
        ),
        child: const Center(
          child: Text(
            'No ingredients selected',
            style: TextStyle(
              color: AppTheme.textTertiary,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selected Ingredients',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedIngredients.map((ingredient) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.accentGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ingredient,
                      style: const TextStyle(
                        color: AppTheme.accentGreen,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIngredients.remove(ingredient);
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        color: AppTheme.accentGreen,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionalPreview() {
    // Calculate estimated nutrition based on selected ingredients
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;

    for (final ingredientName in _selectedIngredients) {
      final ingredient = _availableIngredients.firstWhere(
        (ing) => ing.name == ingredientName,
        orElse: () => _availableIngredients.first,
      );
      // Estimate 100g per ingredient for preview
      totalCalories += ingredient.caloriesPer100g;
      totalProtein += ingredient.proteinPer100g;
      totalCarbs += ingredient.carbsPer100g;
      totalFat += ingredient.fatPer100g;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Text(
            'Estimated Nutrition (per serving)',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNutritionItem('Calories', '${totalCalories.toInt()}', AppTheme.accentRed),
              _buildNutritionItem('Protein', '${totalProtein.toInt()}g', AppTheme.accentGreen),
              _buildNutritionItem('Carbs', '${totalCarbs.toInt()}g', AppTheme.accentBlue),
              _buildNutritionItem('Fat', '${totalFat.toInt()}g', AppTheme.accentYellow),
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
            fontSize: 18,
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

  void _saveMeal() {
    if (_formKey.currentState!.validate()) {
      // Create the meal object
      final meal = Meal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        calories: 0, // Will be calculated from ingredients
        protein: 0,
        carbs: 0,
        fat: 0,
        fiber: 0,
        imageUrl: '',
        ingredients: _selectedIngredients,
        category: _selectedCategory,
        prepTime: int.parse(_prepTimeController.text),
        cookTime: int.parse(_cookTimeController.text),
        servings: int.parse(_servingsController.text),
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Meal "${meal.name}" created successfully!'),
          backgroundColor: AppTheme.accentGreen,
        ),
      );

      // Navigate back
      context.pop();
    }
  }
}
