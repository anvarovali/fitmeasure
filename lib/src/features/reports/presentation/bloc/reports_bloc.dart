import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(const ReportsInitial()) {
    on<ReportsStarted>(_onReportsStarted);
  }
  
  void _onReportsStarted(ReportsStarted event, Emitter<ReportsState> emit) {
    emit(const ReportsLoaded());
  }
}

