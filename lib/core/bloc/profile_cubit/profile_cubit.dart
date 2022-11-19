
import 'package:flutter/material.dart';

import '../../core.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.coreRepository) : super(ProfileInitial());
  final CoreRepository coreRepository;

  void logout() async {
    emit(ProfileLoading());
    try {
      coreRepository.localRepository.clearDatabase();
      emit(ProfileLogoutSuccess());
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(ProfileError(message));
    }
  }
}
