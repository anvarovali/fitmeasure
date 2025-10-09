import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/meal.dart';
import '../../domain/models/ingredient.dart';
import '../../data/meals_service.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild to update floating action button
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          'Meals',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppTheme.textPrimary),
            onPressed: () {
              context.push('/create-meal');
            },
            tooltip: 'Create Meal',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.textPrimary,
          labelColor: AppTheme.textPrimary,
          unselectedLabelColor: AppTheme.textTertiary,
          tabs: const [
            Tab(text: 'Meals Database'),
            Tab(text: 'Ingredients'),
          ],
        ),
      ),
      body: MealsPageContent(tabController: _tabController),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton(
              onPressed: () {
                context.push('/create-ingredient');
              },
              backgroundColor: AppTheme.accentGreen,
              child: const Icon(Icons.add, color: AppTheme.textPrimary),
              tooltip: 'Create Ingredient',
            )
          : null,
    );
  }
}

class MealsPageContent extends StatefulWidget {
  final TabController? tabController;
  
  const MealsPageContent({super.key, this.tabController});

  @override
  State<MealsPageContent> createState() => _MealsPageContentState();
}

class _MealsPageContentState extends State<MealsPageContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Search controllers
  final TextEditingController _mealsSearchController = TextEditingController();
  final TextEditingController _ingredientsSearchController = TextEditingController();
  
  // Data
  List<Meal> _meals = [];
  List<Ingredient> _ingredients = [];
  List<Meal> _filteredMeals = [];
  List<Ingredient> _filteredIngredients = [];
  
  // Category filtering
  IngredientCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _tabController = widget.tabController ?? TabController(length: 2, vsync: this);
    
    // Initialize data
    _meals = MealsService.getAllMeals();
    _ingredients = MealsService.getAllIngredients();
    _filteredMeals = _meals;
    _filteredIngredients = _ingredients;
    
    // Add search listeners
    _mealsSearchController.addListener(_onMealsSearchChanged);
    _ingredientsSearchController.addListener(_onIngredientsSearchChanged);
  }

  @override
  void dispose() {
    if (widget.tabController == null) {
      _tabController.dispose();
    }
    _mealsSearchController.dispose();
    _ingredientsSearchController.dispose();
    super.dispose();
  }

  void _onMealsSearchChanged() {
    setState(() {
      _filteredMeals = MealsService.searchMeals(_mealsSearchController.text);
    });
  }

  void _onIngredientsSearchChanged() {
    setState(() {
      _filteredIngredients = MealsService.searchIngredients(_ingredientsSearchController.text);
      if (_selectedCategory != null) {
        _filteredIngredients = _filteredIngredients
            .where((ingredient) => ingredient.category == _selectedCategory)
            .toList();
      }
    });
  }

  void _onCategorySelected(IngredientCategory? category) {
    setState(() {
      _selectedCategory = category;
      if (category == null) {
        _filteredIngredients = MealsService.searchIngredients(_ingredientsSearchController.text);
      } else {
        _filteredIngredients = MealsService.searchIngredients(_ingredientsSearchController.text)
            .where((ingredient) => ingredient.category == category)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // If we have an external tabController, don't show our own tab bar
    if (widget.tabController != null) {
      return TabBarView(
        controller: _tabController,
        children: [
          _buildMealsDatabaseTab(),
          _buildIngredientsTab(),
        ],
      );
    }
    
    // If no external tabController, show our own tab bar
    return Column(
      children: [
        // Tab bar for main page
        Container(
          color: AppTheme.primaryDark,
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppTheme.textPrimary,
            labelColor: AppTheme.textPrimary,
            unselectedLabelColor: AppTheme.textTertiary,
            tabs: const [
              Tab(text: 'Meals Database'),
              Tab(text: 'Ingredients'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildMealsDatabaseTab(),
              _buildIngredientsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMealsDatabaseTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search bar
          TextField(
            controller: _mealsSearchController,
            style: const TextStyle(color: AppTheme.textPrimary),
            decoration: InputDecoration(
              hintText: 'Search meals...',
              hintStyle: const TextStyle(color: AppTheme.textTertiary),
              prefixIcon: const Icon(Icons.search, color: AppTheme.textTertiary),
              border: OutlineInputBorder(
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
          ),
          const SizedBox(height: 16),
          // Meals list
          Expanded(
            child: _filteredMeals.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppTheme.textTertiary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No meals found',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search terms',
                          style: TextStyle(
                            color: AppTheme.textTertiary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredMeals.length,
                    itemBuilder: (context, index) {
                      final meal = _filteredMeals[index];
                      return _buildMealCard(meal);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search bar
          TextField(
            controller: _ingredientsSearchController,
            style: const TextStyle(color: AppTheme.textPrimary),
            decoration: InputDecoration(
              hintText: 'Search ingredients...',
              hintStyle: const TextStyle(color: AppTheme.textTertiary),
              prefixIcon: const Icon(Icons.search, color: AppTheme.textTertiary),
              border: OutlineInputBorder(
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
          ),
          const SizedBox(height: 16),
          // Category buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip('All', _selectedCategory == null),
                const SizedBox(width: 8),
                ...MealsService.getAllCategories().map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildCategoryChip(
                      category.displayName,
                      _selectedCategory == category,
                      onTap: () => _onCategorySelected(category),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Ingredients list
          Expanded(
            child: _filteredIngredients.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppTheme.textTertiary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No ingredients found',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or category filter',
                          style: TextStyle(
                            color: AppTheme.textTertiary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredIngredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = _filteredIngredients[index];
                      return _buildIngredientCard(ingredient);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(Meal meal) {
    return GestureDetector(
      onTap: () {
        context.push('/meal/${meal.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.textTertiary.withOpacity(0.3)),
        ),
        child: Row(
          children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.textTertiary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.restaurant,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${meal.calories.toInt()} calories',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'P: ${meal.protein.toInt()}g • C: ${meal.carbs.toInt()}g • F: ${meal.fat.toInt()}g',
                  style: const TextStyle(
                    color: AppTheme.textTertiary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${meal.totalTime} min • ${meal.servings} serving${meal.servings > 1 ? 's' : ''}',
                  style: const TextStyle(
                    color: AppTheme.textTertiary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: AppTheme.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added ${meal.name} to log'),
                  backgroundColor: AppTheme.accentGreen,
                ),
              );
            },
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildIngredientCard(Ingredient ingredient) {
    return GestureDetector(
      onTap: () {
        context.push('/ingredient/${ingredient.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.textTertiary.withOpacity(0.2)),
        ),
        child: Row(
          children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.textTertiary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              _getIngredientIcon(ingredient.category),
              color: AppTheme.textSecondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingredient.name,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${ingredient.caloriesPer100g.toInt()} cal/100g',
                  style: const TextStyle(
                    color: AppTheme.textTertiary,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'P: ${ingredient.proteinPer100g.toInt()}g • C: ${ingredient.carbsPer100g.toInt()}g • F: ${ingredient.fatPer100g.toInt()}g',
                  style: const TextStyle(
                    color: AppTheme.textTertiary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: AppTheme.textPrimary, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added ${ingredient.name} to meal'),
                  backgroundColor: AppTheme.accentGreen,
                ),
              );
            },
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () {
        if (label == 'All') {
          _onCategorySelected(null);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.textPrimary : AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.textPrimary : AppTheme.textTertiary.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.primaryDark : AppTheme.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
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
