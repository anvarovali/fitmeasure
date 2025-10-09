# FitMeasure - Fitness Tracking App

A Flutter-based fitness tracking application with a comprehensive onboarding flow and dashboard featuring nutrition tracking and analytics.

## Features

### Onboarding Flow
- **Sex Selection**: Choose between Male/Female
- **Birth Date**: Date picker for age calculation
- **Height**: Support for both Feet/Inches and Centimeters
- **Weight**: Support for both Pounds and Kilograms with slider
- **Body Fat Level**: Visual grid selection with percentage ranges
- **Expenditure Calculation**: Automatic BMR calculation using Mifflin-St Jeor equation
- **Goal Setting**: Target weight and goal rate configuration
- **Diet Preference**: Choose from Balanced, Low-fat, Low-carb, or Keto

### Dashboard
- **Daily Nutrition Overview**: Calorie tracking with circular progress indicator
- **Macronutrient Breakdown**: Protein, Fat, and Carbs with progress bars
- **Analytics Charts**: Expenditure and Weight trend charts using Syncfusion
- **Search Functionality**: Food search with barcode scanner integration
- **Bottom Navigation**: Easy access to different app sections

## Technical Stack

- **Framework**: Flutter 3.0+
- **State Management**: BLoC (flutter_bloc)
- **Navigation**: GoRouter
- **Charts**: Syncfusion Flutter Charts
- **Theme**: Custom dark theme
- **Architecture**: Clean Architecture with feature-based structure

## Project Structure

```
lib/
├── core/
│   ├── theme/           # App theme configuration
│   ├── widgets/         # Reusable UI components
│   ├── navigation/      # App routing
│   └── di/             # Dependency injection
├── features/
│   ├── onboarding/     # Onboarding flow
│   │   ├── domain/     # Models and entities
│   │   └── presentation/
│   │       ├── bloc/   # State management
│   │       └── pages/  # UI screens
│   └── dashboard/      # Main dashboard
└── main.dart
```

## Getting Started

1. **Prerequisites**
   - Flutter SDK 3.0 or higher
   - Dart SDK 3.0 or higher

2. **Installation**
   ```bash
   git clone <repository-url>
   cd fitmeasure
   flutter pub get
   ```

3. **Run the App**
   ```bash
   flutter run
   ```

## Key Dependencies

- `flutter_bloc: ^8.1.3` - State management
- `go_router: ^12.1.3` - Navigation
- `syncfusion_flutter_charts: ^24.1.41` - Charts
- `shared_preferences: ^2.2.2` - Local storage
- `sqflite: ^2.3.0` - Database

## Design Features

- **Dark Mode Only**: Consistent dark theme throughout the app
- **Material Design 3**: Modern UI components
- **Responsive Layout**: Adapts to different screen sizes
- **Smooth Animations**: Enhanced user experience
- **Accessibility**: Screen reader support and proper contrast ratios

## Onboarding Flow

The app guides users through a comprehensive setup process:

1. **Personal Information**: Sex, birth date, height, weight
2. **Body Composition**: Visual body fat level assessment
3. **Metabolic Calculation**: Automatic expenditure estimation
4. **Goal Setting**: Target weight and timeline configuration
5. **Diet Preferences**: Nutritional approach selection

## Dashboard Features

- **Real-time Tracking**: Daily calorie and macro monitoring
- **Visual Analytics**: Trend charts for expenditure and weight
- **Goal Progress**: Visual indicators for target achievement
- **Food Search**: Quick access to nutritional information

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.