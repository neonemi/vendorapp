import 'dart:io';

import 'package:flutter/material.dart';

import '../../core.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this.coreRepository) : super(UpdateProfileInitial());
  final CoreRepository coreRepository;

  void updateProfile(
      {required String mobile,
      required String name,
      required String email,
      required File? imageFile,
      required String? dob,
      required String? anniversary,
      }) async {
    emit(UpdateProfileLoading());
    try {
      UpdateProfileResponse response = await coreRepository.updateProfile(
          mobile: mobile,
          name: name,
          email: email,
          userId: coreRepository.localRepository.getUserId(),
          imageFile: imageFile,
          dob: dob,
          anniversary: anniversary,
          address: coreRepository.localRepository.getAddress());
      emit(UpdateProfileSuccess(response));
      coreRepository.localRepository.setAddress(response.data!.address??"");
      coreRepository.localRepository.setAnniversary(response.data!.anniversary??"");
      coreRepository.localRepository.setUserName(response.data!.name??"");
      coreRepository.localRepository.setMobile(response.data!.mobile??"");
      coreRepository.localRepository.setDob(response.data!.dob??"");
      coreRepository.localRepository.setUserEmail(response.data!.email??"");
      coreRepository.localRepository.setUserImage(response.data!.image??"");
      coreRepository.localRepository.saveToken(response.data!.token??"");
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(UpdateProfileError(message));
    }
  }
}
