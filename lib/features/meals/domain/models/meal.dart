class Meal {
  final String id;
  final String name;
  final String description;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
  final String imageUrl;
  final List<String> ingredients;
  final String category;
  final int prepTime; // in minutes
  final int cookTime; // in minutes
  final int servings;

  const Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.imageUrl,
    required this.ingredients,
    required this.category,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
  });

  // Helper method to get total macros per serving
  Map<String, double> get macrosPerServing => {
    'calories': calories / servings,
    'protein': protein / servings,
    'carbs': carbs / servings,
    'fat': fat / servings,
    'fiber': fiber / servings,
  };

  // Helper method to get total time
  int get totalTime => prepTime + cookTime;

  Meal copyWith({
    String? id,
    String? name,
    String? description,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    double? fiber,
    String? imageUrl,
    List<String>? ingredients,
    String? category,
    int? prepTime,
    int? cookTime,
    int? servings,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      category: category ?? this.category,
      prepTime: prepTime ?? this.prepTime,
      cookTime: cookTime ?? this.cookTime,
      servings: servings ?? this.servings,
    );
  }
}
