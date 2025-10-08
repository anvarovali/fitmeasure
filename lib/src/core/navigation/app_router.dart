import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/initializer/presentation/pages/initializer_page.dart';
import '../../features/main_page.dart';

class AppRoutes {
  static const String initializer = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';
  static const String main = '/main';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.initializer,
    routes: [
      GoRoute(
        path: AppRoutes.initializer,
        builder: (context, state) => const InitializerPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (context, state) => const MainPage(),
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
