part of 'reports_bloc.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();
  
  @override
  List<Object?> get props => [];
}

class ReportsInitial extends ReportsState {
  const ReportsInitial();
}

class ReportsLoading extends ReportsState {
  const ReportsLoading();
}

class ReportsLoaded extends ReportsState {
  const ReportsLoaded();
}

