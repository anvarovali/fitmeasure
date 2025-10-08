enum Environment {
  development,
  staging,
  production,
}

class AppConfig {
  static Environment _environment = Environment.development;
  
  static Environment get environment => _environment;
  
  static void setEnvironment(Environment env) {
    _environment = env;
  }
  
  static String get baseUrl {
    switch (_environment) {
      case Environment.development:
        return 'https://dev-api.fitmeasure.com';
      case Environment.staging:
        return 'https://staging-api.fitmeasure.com';
      case Environment.production:
        return 'https://api.fitmeasure.com';
    }
  }
  
  static bool get isDevelopment => _environment == Environment.development;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.production;
}

