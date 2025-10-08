import 'package:equatable/equatable.dart';

abstract class BaseUseCase<T, Params> {
  Future<T> call(Params params);
}

abstract class UseCaseParams extends Equatable {
  const UseCaseParams();
  
  @override
  List<Object?> get props => [];
}

class NoParams extends UseCaseParams {
  const NoParams();
}

