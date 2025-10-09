import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/onboarding/presentation/pages/sex_selection_page.dart';
import '../../features/onboarding/presentation/pages/birth_date_page.dart';
import '../../features/onboarding/presentation/pages/height_page.dart';
import '../../features/onboarding/presentation/pages/weight_page.dart';
import '../../features/onboarding/presentation/pages/body_fat_page.dart';
import '../../features/onboarding/presentation/pages/expenditure_page.dart';
import '../../features/onboarding/presentation/pages/goal_setting_page.dart';
import '../../features/onboarding/presentation/pages/diet_preference_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_signin_page.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';
import '../../features/onboarding/presentation/bloc/onboarding_event.dart';
import '../../features/meals/presentation/pages/meal_detail_page.dart';
import '../../features/meals/presentation/pages/ingredient_detail_page.dart';
import '../../features/meals/presentation/pages/create_meal_page.dart';
import '../../features/meals/presentation/pages/create_ingredient_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/log/presentation/pages/log_page.dart';
import '../../features/meals/presentation/pages/meals_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/food_log_history/presentation/pages/food_log_history_page.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String sexSelection = '/onboarding/sex';
  static const String birthDate = '/onboarding/birth-date';
  static const String height = '/onboarding/height';
  static const String weight = '/onboarding/weight';
  static const String bodyFat = '/onboarding/body-fat';
  static const String expenditure = '/onboarding/expenditure';
  static const String goalSetting = '/onboarding/goal-setting';
  static const String dietPreference = '/onboarding/diet-preference';
  static const String onboardingSignIn = '/onboarding/signin';
  static const String dashboard = '/dashboard';
  static const String log = '/log';
  static const String meals = '/meals';
  static const String profile = '/profile';
  static const String logFood = '/log-food';
  static const String foodLogHistory = '/food-log-history';
  static const String main = '/main';
  static const String mealDetail = '/meal';
  static const String ingredientDetail = '/ingredient';
  static const String createMeal = '/create-meal';
  static const String createIngredient = '/create-ingredient';
}

class AppRouter {
  static final OnboardingBloc _onboardingBloc = OnboardingBloc();
  
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.welcome,
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.sexSelection,
        builder: (context, state) => BlocProvider.value(
          value: _onboardingBloc..add(const OnboardingStarted()),
          child: const SexSelectionPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.birthDate,
        builder: (context, state) => BlocProvider.value(
          value: _onboardingBloc,
          child: const BirthDatePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.height,
        builder: (context, state) => BlocProvider.value(
          value: _onboardingBloc,
          child: const HeightPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.weight,
        builder: (context, state) => BlocProvider.value(
          value: _onboardingBloc,
          child: const WeightPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.bodyFat,
        builder: (context, state) => BlocProvider.value(
          value: _onboardingBloc,
          child: const BodyFatPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.expenditure,
        builder: (context, state) => BlocProvider.value(
          value: _onboardingBloc,
          child: const ExpenditurePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.goalSetting,
        builder: (context, state) => BlocProvider.value(
          value: _onboardingBloc,
          child: const GoalSettingPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.dietPreference,
        builder: (context, state) => BlocProvider.value(
          value: _onboardingBloc,
          child: const DietPreferencePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.onboardingSignIn,
        builder: (context, state) => BlocProvider.value(
          value: _onboardingBloc,
          child: const OnboardingSignInPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.log,
        builder: (context, state) => const LogPage(),
      ),
      GoRoute(
        path: AppRoutes.meals,
        builder: (context, state) => const MealsPage(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.foodLogHistory,
        builder: (context, state) => const FoodLogHistoryPage(),
      ),
      GoRoute(
        path: '${AppRoutes.mealDetail}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MealDetailPage(mealId: id);
        },
      ),
      GoRoute(
        path: '${AppRoutes.ingredientDetail}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return IngredientDetailPage(ingredientId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.createMeal,
        builder: (context, state) => const CreateMealPage(),
      ),
      GoRoute(
        path: AppRoutes.createIngredient,
        builder: (context, state) => const CreateIngredientPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Route not found: ${state.uri}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.main),
              child: const Text('Go to Main'),
            ),
          ],
        ),
      ),
    ),
  );
}
