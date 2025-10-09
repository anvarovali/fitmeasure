class AppConstants {
  // App Info
  static const String appName = 'Fit Measure';
  static const String appVersion = '1.0.0';
  
  // API
  static const String baseUrl = 'https://api.fitmeasure.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  
  // Database
  static const String databaseName = 'fit_measure.db';
  static const int databaseVersion = 1;
  
  // UI
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 8.0;
  static const double defaultElevation = 2.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}
