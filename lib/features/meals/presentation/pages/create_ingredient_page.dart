import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/ingredient.dart';

class CreateIngredientPage extends StatefulWidget {
  const CreateIngredientPage({super.key});

  @override
  State<CreateIngredientPage> createState() => _CreateIngredientPageState();
}

class _CreateIngredientPageState extends State<CreateIngredientPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  final _fiberController = TextEditingController();
  final _sugarController = TextEditingController();

  IngredientCategory _selectedCategory = IngredientCategory.other;
  List<String> _selectedAllergens = [];
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isGlutenFree = true;

  final List<String> _availableAllergens = [
    'Milk',
    'Eggs',
    'Fish',
    'Shellfish',
    'Tree Nuts',
    'Peanuts',
    'Wheat',
    'Soybeans',
    'Sesame',
  ];

  @override
  void initState() {
    super.initState();
    // Set default values
    _caloriesController.text = '0';
    _proteinController.text = '0';
    _carbsController.text = '0';
    _fatController.text = '0';
    _fiberController.text = '0';
    _sugarController.text = '0';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _fiberController.dispose();
    _sugarController.dispose();
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
          'Create Ingredient',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: _saveIngredient,
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
                    label: 'Ingredient Name',
                    hint: 'Enter ingredient name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an ingredient name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    hint: 'Enter ingredient description',
                    maxLines: 2,
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

              // Nutritional Information Section
              _buildSection(
                'Nutritional Information (per 100g)',
                [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _caloriesController,
                          label: 'Calories',
                          hint: 'Enter calories',
                          keyboardType: TextInputType.number,
                          validator: _validateNumber,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: _proteinController,
                          label: 'Protein (g)',
                          hint: 'Enter protein',
                          keyboardType: TextInputType.number,
                          validator: _validateNumber,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _carbsController,
                          label: 'Carbs (g)',
                          hint: 'Enter carbs',
                          keyboardType: TextInputType.number,
                          validator: _validateNumber,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: _fatController,
                          label: 'Fat (g)',
                          hint: 'Enter fat',
                          keyboardType: TextInputType.number,
                          validator: _validateNumber,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _fiberController,
                          label: 'Fiber (g)',
                          hint: 'Enter fiber',
                          keyboardType: TextInputType.number,
                          validator: _validateNumber,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: _sugarController,
                          label: 'Sugar (g)',
                          hint: 'Enter sugar',
                          keyboardType: TextInputType.number,
                          validator: _validateNumber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Dietary Information Section
              _buildSection(
                'Dietary Information',
                [
                  _buildDietaryOptions(),
                ],
              ),
              const SizedBox(height: 24),

              // Allergens Section
              _buildSection(
                'Allergens',
                [
                  _buildAllergenSelector(),
                ],
              ),
              const SizedBox(height: 24),

              // Nutritional Preview
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
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.secondaryDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
          ),
          child: DropdownButtonFormField<IngredientCategory>(
            value: _selectedCategory,
            dropdownColor: AppTheme.secondaryDark,
            style: const TextStyle(color: AppTheme.textPrimary),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            items: IngredientCategory.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Row(
                  children: [
                    Icon(
                      _getIngredientIcon(category),
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(category.displayName),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDietaryOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          _buildDietaryOption('Vegan', _isVegan, (value) {
            setState(() {
              _isVegan = value!;
              if (_isVegan) _isVegetarian = true;
            });
          }),
          _buildDietaryOption('Vegetarian', _isVegetarian, (value) {
            setState(() {
              _isVegetarian = value!;
              if (!_isVegetarian) _isVegan = false;
            });
          }),
          _buildDietaryOption('Gluten Free', _isGlutenFree, (value) {
            setState(() {
              _isGlutenFree = value!;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildDietaryOption(String label, bool value, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      title: Text(
        label,
        style: const TextStyle(color: AppTheme.textPrimary),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.accentGreen,
      checkColor: AppTheme.textPrimary,
    );
  }

  Widget _buildAllergenSelector() {
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
            'Select Allergens',
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
            children: _availableAllergens.map((allergen) {
              final isSelected = _selectedAllergens.contains(allergen);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedAllergens.remove(allergen);
                    } else {
                      _selectedAllergens.add(allergen);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.accentRed.withOpacity(0.2) : AppTheme.secondaryDark,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? AppTheme.accentRed : AppTheme.textTertiary.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    allergen,
                    style: TextStyle(
                      color: isSelected ? AppTheme.accentRed : AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionalPreview() {
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
            'Nutritional Information (per 100g)',
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
              _buildNutritionItem('Calories', _caloriesController.text, AppTheme.accentRed),
              _buildNutritionItem('Protein', '${_proteinController.text}g', AppTheme.accentGreen),
              _buildNutritionItem('Carbs', '${_carbsController.text}g', AppTheme.accentBlue),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNutritionItem('Fat', '${_fatController.text}g', AppTheme.accentYellow),
              _buildNutritionItem('Fiber', '${_fiberController.text}g', AppTheme.accentPurple),
              _buildNutritionItem('Sugar', '${_sugarController.text}g', AppTheme.accentRed),
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

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (double.tryParse(value) == null) {
      return 'Invalid number';
    }
    if (double.parse(value) < 0) {
      return 'Must be positive';
    }
    return null;
  }

  void _saveIngredient() {
    if (_formKey.currentState!.validate()) {
      // Create the ingredient object
      final ingredient = Ingredient(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        caloriesPer100g: double.parse(_caloriesController.text),
        proteinPer100g: double.parse(_proteinController.text),
        carbsPer100g: double.parse(_carbsController.text),
        fatPer100g: double.parse(_fatController.text),
        fiberPer100g: double.parse(_fiberController.text),
        sugarPer100g: double.parse(_sugarController.text),
        imageUrl: '',
        category: _selectedCategory,
        allergens: _selectedAllergens,
        isVegan: _isVegan,
        isVegetarian: _isVegetarian,
        isGlutenFree: _isGlutenFree,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ingredient "${ingredient.name}" created successfully!'),
          backgroundColor: AppTheme.accentGreen,
        ),
      );

      // Navigate back
      context.pop();
    }
  }
}
