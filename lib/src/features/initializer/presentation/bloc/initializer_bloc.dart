import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/persistent_storage/local_storage.dart';

part 'initializer_event.dart';
part 'initializer_state.dart';

class InitializerBloc extends Bloc<InitializerEvent, InitializerState> {
  final LocalStorage _localStorage;
  
  InitializerBloc({LocalStorage? localStorage}) 
      : _localStorage = localStorage ?? LocalStorage(),
        super(const InitializerLoading()) {
    on<InitializerStarted>(_onInitializerStarted);
  }
  
  Future<void> _onInitializerStarted(
    InitializerStarted event,
    Emitter<InitializerState> emit,
  ) async {
    try {
      // Simulate initialization delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Check if user is authenticated
      final token = _localStorage.getToken();
      
      if (token != null) {
        emit(const InitializerAuthenticated());
      } else {
        emit(const InitializerUnauthenticated());
      }
    } catch (e) {
      emit(InitializerError(e.toString()));
    }
  }
}

