import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
  }
  
  void _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) {
    emit(const HomeLoaded());
  }
}

