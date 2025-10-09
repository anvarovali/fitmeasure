enum IngredientCategory {
  protein,
  carbs,
  fats,
  vegetables,
  fruits,
  dairy,
  grains,
  nuts,
  spices,
  other;

  String get displayName {
    switch (this) {
      case IngredientCategory.protein:
        return 'Proteins';
      case IngredientCategory.carbs:
        return 'Carbs';
      case IngredientCategory.fats:
        return 'Fats';
      case IngredientCategory.vegetables:
        return 'Vegetables';
      case IngredientCategory.fruits:
        return 'Fruits';
      case IngredientCategory.dairy:
        return 'Dairy';
      case IngredientCategory.grains:
        return 'Grains';
      case IngredientCategory.nuts:
        return 'Nuts';
      case IngredientCategory.spices:
        return 'Spices';
      case IngredientCategory.other:
        return 'Other';
    }
  }
}

class Ingredient {
  final String id;
  final String name;
  final String description;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;
  final double fiberPer100g;
  final double sugarPer100g;
  final String imageUrl;
  final IngredientCategory category;
  final List<String> allergens;
  final bool isVegan;
  final bool isVegetarian;
  final bool isGlutenFree;

  const Ingredient({
    required this.id,
    required this.name,
    required this.description,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
    required this.fiberPer100g,
    required this.sugarPer100g,
    required this.imageUrl,
    required this.category,
    required this.allergens,
    required this.isVegan,
    required this.isVegetarian,
    required this.isGlutenFree,
  });

  // Helper method to get macros for a specific amount
  Map<String, double> getMacrosForAmount(double amountInGrams) {
    final multiplier = amountInGrams / 100.0;
    return {
      'calories': caloriesPer100g * multiplier,
      'protein': proteinPer100g * multiplier,
      'carbs': carbsPer100g * multiplier,
      'fat': fatPer100g * multiplier,
      'fiber': fiberPer100g * multiplier,
      'sugar': sugarPer100g * multiplier,
    };
  }

  // Helper method to get category display name
  String get categoryDisplayName {
    switch (category) {
      case IngredientCategory.protein:
        return 'Proteins';
      case IngredientCategory.carbs:
        return 'Carbs';
      case IngredientCategory.fats:
        return 'Fats';
      case IngredientCategory.vegetables:
        return 'Vegetables';
      case IngredientCategory.fruits:
        return 'Fruits';
      case IngredientCategory.dairy:
        return 'Dairy';
      case IngredientCategory.grains:
        return 'Grains';
      case IngredientCategory.nuts:
        return 'Nuts';
      case IngredientCategory.spices:
        return 'Spices';
      case IngredientCategory.other:
        return 'Other';
    }
  }

  Ingredient copyWith({
    String? id,
    String? name,
    String? description,
    double? caloriesPer100g,
    double? proteinPer100g,
    double? carbsPer100g,
    double? fatPer100g,
    double? fiberPer100g,
    double? sugarPer100g,
    String? imageUrl,
    IngredientCategory? category,
    List<String>? allergens,
    bool? isVegan,
    bool? isVegetarian,
    bool? isGlutenFree,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      fiberPer100g: fiberPer100g ?? this.fiberPer100g,
      sugarPer100g: sugarPer100g ?? this.sugarPer100g,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      allergens: allergens ?? this.allergens,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
    );
  }
}
