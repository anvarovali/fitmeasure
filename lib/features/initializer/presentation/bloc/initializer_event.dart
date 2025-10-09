part of 'initializer_bloc.dart';

abstract class InitializerEvent extends Equatable {
  const InitializerEvent();
  
  @override
  List<Object?> get props => [];
}

class InitializerStarted extends InitializerEvent {
  const InitializerStarted();
}

