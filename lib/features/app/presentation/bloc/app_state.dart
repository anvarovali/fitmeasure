part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();
  
  @override
  List<Object?> get props => [];
}

class AppInitial extends AppState {
  const AppInitial();
}

class AppLoaded extends AppState {
  final String themeMode;
  
  const AppLoaded({this.themeMode = 'system'});
  
  @override
  List<Object?> get props => [themeMode];
}

