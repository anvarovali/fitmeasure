part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
  
  @override
  List<Object?> get props => [];
}

class AppStarted extends AppEvent {
  const AppStarted();
}

class AppThemeChanged extends AppEvent {
  final String themeMode;
  
  const AppThemeChanged(this.themeMode);
  
  @override
  List<Object?> get props => [themeMode];
}

