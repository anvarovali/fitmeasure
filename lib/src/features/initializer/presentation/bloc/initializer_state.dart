part of 'initializer_bloc.dart';

abstract class InitializerState extends Equatable {
  const InitializerState();
  
  @override
  List<Object?> get props => [];
}

class InitializerLoading extends InitializerState {
  const InitializerLoading();
}

class InitializerAuthenticated extends InitializerState {
  const InitializerAuthenticated();
}

class InitializerUnauthenticated extends InitializerState {
  const InitializerUnauthenticated();
}

class InitializerError extends InitializerState {
  final String message;
  
  const InitializerError(this.message);
  
  @override
  List<Object?> get props => [message];
}

