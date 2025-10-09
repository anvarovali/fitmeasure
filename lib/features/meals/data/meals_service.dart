import '../domain/models/meal.dart';
import '../domain/models/ingredient.dart';

class MealsService {
  static final List<Meal> _meals = [
    Meal(
      id: '1',
      name: 'Grilled Chicken Breast',
      description: 'Lean protein with herbs and spices',
      calories: 165,
      protein: 31,
      carbs: 0,
      fat: 3.6,
      fiber: 0,
      imageUrl: '',
      ingredients: ['Chicken Breast', 'Olive Oil', 'Salt', 'Pepper', 'Garlic'],
      category: 'Protein',
      prepTime: 10,
      cookTime: 20,
      servings: 1,
    ),
    Meal(
      id: '2',
      name: 'Quinoa Salad Bowl',
      description: 'Nutritious grain salad with vegetables',
      calories: 320,
      protein: 12,
      carbs: 45,
      fat: 8,
      fiber: 6,
      imageUrl: '',
      ingredients: ['Quinoa', 'Cucumber', 'Tomato', 'Avocado', 'Lemon', 'Olive Oil'],
      category: 'Vegetarian',
      prepTime: 15,
      cookTime: 15,
      servings: 1,
    ),
    Meal(
      id: '3',
      name: 'Salmon with Sweet Potato',
      description: 'Omega-3 rich fish with complex carbs',
      calories: 420,
      protein: 35,
      carbs: 35,
      fat: 15,
      fiber: 5,
      imageUrl: '',
      ingredients: ['Salmon Fillet', 'Sweet Potato', 'Broccoli', 'Olive Oil', 'Lemon'],
      category: 'Protein',
      prepTime: 10,
      cookTime: 25,
      servings: 1,
    ),
    Meal(
      id: '4',
      name: 'Greek Yogurt Parfait',
      description: 'Protein-rich breakfast with berries',
      calories: 180,
      protein: 15,
      carbs: 25,
      fat: 2,
      fiber: 4,
      imageUrl: '',
      ingredients: ['Greek Yogurt', 'Blueberries', 'Strawberries', 'Granola', 'Honey'],
      category: 'Breakfast',
      prepTime: 5,
      cookTime: 0,
      servings: 1,
    ),
    Meal(
      id: '5',
      name: 'Vegetable Stir Fry',
      description: 'Colorful mix of fresh vegetables',
      calories: 150,
      protein: 6,
      carbs: 20,
      fat: 5,
      fiber: 8,
      imageUrl: '',
      ingredients: ['Bell Peppers', 'Broccoli', 'Carrots', 'Soy Sauce', 'Ginger', 'Garlic'],
      category: 'Vegetarian',
      prepTime: 15,
      cookTime: 10,
      servings: 1,
    ),
  ];

  static final List<Ingredient> _ingredients = [
    Ingredient(
      id: '1',
      name: 'Chicken Breast',
      description: 'Lean protein source',
      caloriesPer100g: 165,
      proteinPer100g: 31,
      carbsPer100g: 0,
      fatPer100g: 3.6,
      fiberPer100g: 0,
      sugarPer100g: 0,
      imageUrl: '',
      category: IngredientCategory.protein,
      allergens: [],
      isVegan: false,
      isVegetarian: false,
      isGlutenFree: true,
    ),
    Ingredient(
      id: '2',
      name: 'Quinoa',
      description: 'Complete protein grain',
      caloriesPer100g: 120,
      proteinPer100g: 4.4,
      carbsPer100g: 22,
      fatPer100g: 1.9,
      fiberPer100g: 2.8,
      sugarPer100g: 0.9,
      imageUrl: '',
      category: IngredientCategory.grains,
      allergens: [],
      isVegan: true,
      isVegetarian: true,
      isGlutenFree: true,
    ),
    Ingredient(
      id: '3',
      name: 'Salmon',
      description: 'Omega-3 rich fish',
      caloriesPer100g: 208,
      proteinPer100g: 25,
      carbsPer100g: 0,
      fatPer100g: 12,
      fiberPer100g: 0,
      sugarPer100g: 0,
      imageUrl: '',
      category: IngredientCategory.protein,
      allergens: ['Fish'],
      isVegan: false,
      isVegetarian: false,
      isGlutenFree: true,
    ),
    Ingredient(
      id: '4',
      name: 'Greek Yogurt',
      description: 'High protein dairy',
      caloriesPer100g: 59,
      proteinPer100g: 10,
      carbsPer100g: 3.6,
      fatPer100g: 0.4,
      fiberPer100g: 0,
      sugarPer100g: 3.6,
      imageUrl: '',
      category: IngredientCategory.dairy,
      allergens: ['Milk'],
      isVegan: false,
      isVegetarian: true,
      isGlutenFree: true,
    ),
    Ingredient(
      id: '5',
      name: 'Avocado',
      description: 'Healthy monounsaturated fats',
      caloriesPer100g: 160,
      proteinPer100g: 2,
      carbsPer100g: 8.5,
      fatPer100g: 14.7,
      fiberPer100g: 6.7,
      sugarPer100g: 0.7,
      imageUrl: '',
      category: IngredientCategory.fruits,
      allergens: [],
      isVegan: true,
      isVegetarian: true,
      isGlutenFree: true,
    ),
    Ingredient(
      id: '6',
      name: 'Broccoli',
      description: 'Nutrient-dense cruciferous vegetable',
      caloriesPer100g: 34,
      proteinPer100g: 2.8,
      carbsPer100g: 6.6,
      fatPer100g: 0.4,
      fiberPer100g: 2.6,
      sugarPer100g: 1.5,
      imageUrl: '',
      category: IngredientCategory.vegetables,
      allergens: [],
      isVegan: true,
      isVegetarian: true,
      isGlutenFree: true,
    ),
    Ingredient(
      id: '7',
      name: 'Sweet Potato',
      description: 'Complex carbohydrate with beta-carotene',
      caloriesPer100g: 86,
      proteinPer100g: 1.6,
      carbsPer100g: 20.1,
      fatPer100g: 0.1,
      fiberPer100g: 3,
      sugarPer100g: 4.2,
      imageUrl: '',
      category: IngredientCategory.vegetables,
      allergens: [],
      isVegan: true,
      isVegetarian: true,
      isGlutenFree: true,
    ),
    Ingredient(
      id: '8',
      name: 'Blueberries',
      description: 'Antioxidant-rich berries',
      caloriesPer100g: 57,
      proteinPer100g: 0.7,
      carbsPer100g: 14.5,
      fatPer100g: 0.3,
      fiberPer100g: 2.4,
      sugarPer100g: 10,
      imageUrl: '',
      category: IngredientCategory.fruits,
      allergens: [],
      isVegan: true,
      isVegetarian: true,
      isGlutenFree: true,
    ),
    Ingredient(
      id: '9',
      name: 'Olive Oil',
      description: 'Heart-healthy monounsaturated fat',
      caloriesPer100g: 884,
      proteinPer100g: 0,
      carbsPer100g: 0,
      fatPer100g: 100,
      fiberPer100g: 0,
      sugarPer100g: 0,
      imageUrl: '',
      category: IngredientCategory.fats,
      allergens: [],
      isVegan: true,
      isVegetarian: true,
      isGlutenFree: true,
    ),
    Ingredient(
      id: '10',
      name: 'Almonds',
      description: 'Nutrient-dense tree nuts',
      caloriesPer100g: 579,
      proteinPer100g: 21.2,
      carbsPer100g: 21.6,
      fatPer100g: 49.9,
      fiberPer100g: 12.5,
      sugarPer100g: 4.4,
      imageUrl: '',
      category: IngredientCategory.nuts,
      allergens: ['Tree Nuts'],
      isVegan: true,
      isVegetarian: true,
      isGlutenFree: true,
    ),
  ];

  // Get all meals
  static List<Meal> getAllMeals() {
    return List.from(_meals);
  }

  // Get all ingredients
  static List<Ingredient> getAllIngredients() {
    return List.from(_ingredients);
  }

  // Search meals by name
  static List<Meal> searchMeals(String query) {
    if (query.isEmpty) return getAllMeals();
    
    return _meals.where((meal) =>
      meal.name.toLowerCase().contains(query.toLowerCase()) ||
      meal.description.toLowerCase().contains(query.toLowerCase()) ||
      meal.ingredients.any((ingredient) =>
        ingredient.toLowerCase().contains(query.toLowerCase())
      )
    ).toList();
  }

  // Search ingredients by name
  static List<Ingredient> searchIngredients(String query) {
    if (query.isEmpty) return getAllIngredients();
    
    return _ingredients.where((ingredient) =>
      ingredient.name.toLowerCase().contains(query.toLowerCase()) ||
      ingredient.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // Filter ingredients by category
  static List<Ingredient> getIngredientsByCategory(IngredientCategory category) {
    return _ingredients.where((ingredient) => ingredient.category == category).toList();
  }

  // Get meal by ID
  static Meal? getMealById(String id) {
    try {
      return _meals.firstWhere((meal) => meal.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get ingredient by ID
  static Ingredient? getIngredientById(String id) {
    try {
      return _ingredients.firstWhere((ingredient) => ingredient.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get all categories
  static List<IngredientCategory> getAllCategories() {
    return IngredientCategory.values;
  }
}
