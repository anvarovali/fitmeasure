import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/persistent_storage/local_storage.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LocalStorage _localStorage;
  
  ProfileBloc({LocalStorage? localStorage}) 
      : _localStorage = localStorage ?? LocalStorage(),
        super(const ProfileInitial()) {
    on<ProfileStarted>(_onProfileStarted);
    on<ProfileLogoutRequested>(_onProfileLogoutRequested);
  }
  
  void _onProfileStarted(ProfileStarted event, Emitter<ProfileState> emit) {
    emit(const ProfileLoaded());
  }
  
  Future<void> _onProfileLogoutRequested(
    ProfileLogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await _localStorage.removeToken();
      await _localStorage.removeUserData();
      emit(const ProfileLoggedOut());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
