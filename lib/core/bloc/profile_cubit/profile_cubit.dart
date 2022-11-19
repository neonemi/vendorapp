
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
  void loadData() async {
    emit(ProfileLoading());
    try {
      bool user = await coreRepository.localRepository.isLoggedIn();
      if(user==true){
        String userName= coreRepository.localRepository.getUserName();
        String email= coreRepository.localRepository.getUserEmail();
        String image=await coreRepository.localRepository.getUserImage();
        emit(ProfileSuccess(userName,email,image));
      }else{
        String userName='Guest';
        emit(ProfileGuestSuccess(userName));
      }
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(ProfileError(message));
    }
  }
}
