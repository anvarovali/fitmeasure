import 'package:flutter/material.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});
  
  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Meal List'),
            Tab(text: 'Ingredients'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search meals or ingredients...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMealList(),
                _buildIngredientsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMealList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: _dummyMeals.length,
      itemBuilder: (context, index) {
        final meal = _dummyMeals[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                meal['icon'] as IconData,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            title: Text(
              meal['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${meal['calories']} cal • ${meal['prepTime']}',
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  meal['difficulty'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getDifficultyColor(meal['difficulty'] as String),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      meal['rating'].toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              _showMealDetails(context, meal);
            },
          ),
        );
      },
    );
  }
  
  Widget _buildIngredientsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: _dummyIngredients.length,
      itemBuilder: (context, index) {
        final ingredient = _dummyIngredients[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              child: Icon(
                ingredient['icon'] as IconData,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            title: Text(
              ingredient['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${ingredient['calories']} cal per 100g',
            ),
            trailing: Text(
              ingredient['category'] as String,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () {
              _showIngredientDetails(context, ingredient);
            },
          ),
        );
      },
    );
  }
  
  void _showMealDetails(BuildContext context, Map<String, dynamic> meal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(meal['name'] as String),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calories: ${meal['calories']}'),
            Text('Prep Time: ${meal['prepTime']}'),
            Text('Difficulty: ${meal['difficulty']}'),
            Text('Rating: ${meal['rating']}/5'),
            const SizedBox(height: 16),
            Text(
              'Ingredients:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(meal['ingredients'] as String),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Meal added to favorites!'),
                ),
              );
            },
            child: const Text('Add to Favorites'),
          ),
        ],
      ),
    );
  }
  
  void _showIngredientDetails(BuildContext context, Map<String, dynamic> ingredient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ingredient['name'] as String),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${ingredient['category']}'),
            Text('Calories: ${ingredient['calories']} per 100g'),
            Text('Protein: ${ingredient['protein']}g'),
            Text('Carbs: ${ingredient['carbs']}g'),
            Text('Fat: ${ingredient['fat']}g'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Dummy data for meals
final List<Map<String, dynamic>> _dummyMeals = [
  {
    'name': 'Grilled Chicken Salad',
    'calories': 320,
    'prepTime': '15 min',
    'difficulty': 'Easy',
    'rating': 4.5,
    'icon': Icons.restaurant,
    'ingredients': 'Chicken breast, mixed greens, cherry tomatoes, cucumber, olive oil, lemon',
  },
  {
    'name': 'Quinoa Buddha Bowl',
    'calories': 450,
    'prepTime': '25 min',
    'difficulty': 'Medium',
    'rating': 4.8,
    'icon': Icons.restaurant,
    'ingredients': 'Quinoa, roasted vegetables, chickpeas, avocado, tahini dressing',
  },
  {
    'name': 'Salmon with Sweet Potato',
    'calories': 380,
    'prepTime': '30 min',
    'difficulty': 'Medium',
    'rating': 4.6,
    'icon': Icons.restaurant,
    'ingredients': 'Salmon fillet, sweet potato, broccoli, garlic, herbs',
  },
  {
    'name': 'Greek Yogurt Parfait',
    'calories': 180,
    'prepTime': '5 min',
    'difficulty': 'Easy',
    'rating': 4.2,
    'icon': Icons.local_drink,
    'ingredients': 'Greek yogurt, berries, granola, honey',
  },
  {
    'name': 'Vegetable Stir Fry',
    'calories': 250,
    'prepTime': '20 min',
    'difficulty': 'Easy',
    'rating': 4.3,
    'icon': Icons.restaurant,
    'ingredients': 'Mixed vegetables, tofu, soy sauce, ginger, garlic',
  },
];

// Dummy data for ingredients
final List<Map<String, dynamic>> _dummyIngredients = [
  {
    'name': 'Chicken Breast',
    'calories': 165,
    'category': 'Protein',
    'icon': Icons.restaurant,
    'protein': 31,
    'carbs': 0,
    'fat': 3.6,
  },
  {
    'name': 'Brown Rice',
    'calories': 111,
    'category': 'Grains',
    'icon': Icons.grain,
    'protein': 2.6,
    'carbs': 23,
    'fat': 0.9,
  },
  {
    'name': 'Broccoli',
    'calories': 34,
    'category': 'Vegetables',
    'icon': Icons.eco,
    'protein': 2.8,
    'carbs': 7,
    'fat': 0.4,
  },
  {
    'name': 'Avocado',
    'calories': 160,
    'category': 'Fruits',
    'icon': Icons.restaurant,
    'protein': 2,
    'carbs': 9,
    'fat': 15,
  },
  {
    'name': 'Greek Yogurt',
    'calories': 59,
    'category': 'Dairy',
    'icon': Icons.local_drink,
    'protein': 10,
    'carbs': 3.6,
    'fat': 0.4,
  },
  {
    'name': 'Almonds',
    'calories': 579,
    'category': 'Nuts',
    'icon': Icons.circle,
    'protein': 21,
    'carbs': 22,
    'fat': 50,
  },
];
