import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(super.initialState);
}

abstract class BaseEvent extends Equatable {
  const BaseEvent();
  
  @override
  List<Object?> get props => [];
}

abstract class BaseState extends Equatable {
  const BaseState();
  
  @override
  List<Object?> get props => [];
}

class LoadingState extends BaseState {
  const LoadingState();
}

class ErrorState extends BaseState {
  final String message;
  
  const ErrorState(this.message);
  
  @override
  List<Object?> get props => [message];
}

class SuccessState extends BaseState {
  final String? message;
  
  const SuccessState([this.message]);
  
  @override
  List<Object?> get props => [message];
}

