import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppInitial()) {
    on<AppStarted>(_onAppStarted);
    on<AppThemeChanged>(_onAppThemeChanged);
  }
  
  void _onAppStarted(AppStarted event, Emitter<AppState> emit) {
    emit(const AppLoaded());
  }
  
  void _onAppThemeChanged(AppThemeChanged event, Emitter<AppState> emit) {
    emit(AppLoaded(themeMode: event.themeMode));
  }
}

