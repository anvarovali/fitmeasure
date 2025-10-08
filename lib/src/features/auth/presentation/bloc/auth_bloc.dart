import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/persistent_storage/local_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalStorage _localStorage;
  
  AuthBloc({LocalStorage? localStorage}) 
      : _localStorage = localStorage ?? LocalStorage(),
        super(const AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }
  
  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock authentication - in real app, call API
      if (event.email == 'test@example.com' && event.password == 'password') {
        await _localStorage.saveToken('mock_token');
        await _localStorage.saveUserData({
          'id': 1,
          'name': 'Test User',
          'email': event.email,
        });
        
        emit(const AuthSuccess());
      } else {
        emit(const AuthError('Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  
  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock registration - in real app, call API
      await _localStorage.saveToken('mock_token');
      await _localStorage.saveUserData({
        'id': 1,
        'name': event.name,
        'email': event.email,
      });
      
      emit(const AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  
  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _localStorage.removeToken();
      await _localStorage.removeUserData();
      emit(const AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

