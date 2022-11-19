import 'dart:io';

import 'package:flutter/material.dart';

import '../../core.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this.coreRepository) : super(UpdateProfileInitial());
  final CoreRepository coreRepository;

  void updateProfile(
      {
      required String name,
      required String email,
      required File? imageFile,
      required DateTime? dob,
      required DateTime? anniversary,
      }) async {
    emit(UpdateProfileLoading());
    try {
      UpdateProfileResponse response = await coreRepository.updateProfile(
          name: name,
          email: email,
          imageFile: imageFile,//File
          dob: dob,
          anniversary: anniversary,);

      if(response.data!.address!=null) {
        coreRepository.localRepository.setAddress(response.data!.address.toString());
      }
      if(response.data!.anniversary!=null) {
        coreRepository.localRepository.setAnniversary(response.data!.anniversary.toString());
      }
      if(response.data!.name!=null) {
        coreRepository.localRepository.setUserName(response.data!.name.toString());
      }
      if(response.data!.mobile!=null) {
        coreRepository.localRepository.setMobile(response.data!.mobile.toString());
      }
      if(response.data!.dob!=null) {
        coreRepository.localRepository.setDob(response.data!.dob.toString());
      }
      if(response.data!.email!=null) {
        coreRepository.localRepository.setUserEmail(response.data!.email.toString());
      }
      if(response.data!.image!=null) {
        coreRepository.localRepository.setUserImage(response.data!.image.toString());
      }
      if(response.data!.token!=null) {
        coreRepository.localRepository.saveToken(response.data!.token.toString());
      }
      emit(UpdateProfileSuccess(response));
      print(response.data!.name);
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(UpdateProfileError(message));
    }
  }
  void updateProfileFile(
      {
        required String name,
        required String email,
        required File? imageFile,
        required DateTime? dob,
        required DateTime? anniversary,
      }) async {
    emit(UpdateProfileLoading());
    try {
      UpdateProfileResponse response = await coreRepository.updateProfileFile(
        name: name,
        email: email,
        imageFile: imageFile,//File
        dob: dob,
        anniversary: anniversary,);

      if(response.data!.address!=null) {
        coreRepository.localRepository.setAddress(response.data!.address.toString());
      }
      if(response.data!.anniversary!=null) {
        coreRepository.localRepository.setAnniversary(response.data!.anniversary.toString());
      }
      if(response.data!.name!=null) {
        coreRepository.localRepository.setUserName(response.data!.name.toString());
      }
      if(response.data!.mobile!=null) {
        coreRepository.localRepository.setMobile(response.data!.mobile.toString());
      }
      if(response.data!.dob!=null) {
        coreRepository.localRepository.setDob(response.data!.dob.toString());
      }
      if(response.data!.email!=null) {
        coreRepository.localRepository.setUserEmail(response.data!.email.toString());
      }
      if(response.data!.image!=null) {
        coreRepository.localRepository.setUserImage(response.data!.image.toString());
      }
      if(response.data!.token!=null) {
        coreRepository.localRepository.saveToken(response.data!.token.toString());
      }
      emit(UpdateProfileSuccess(response));
      print(response.data!.name);
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(UpdateProfileError(message));
    }
  }
  void getProfile() async {
    emit(UpdateProfileLoading());
    try {
        String userName= coreRepository.localRepository.getUserName();
        String email= coreRepository.localRepository.getUserEmail();
        String mobile= await coreRepository.localRepository.getMobile();
        String image= await coreRepository.localRepository.getUserImage();
        String dob= await coreRepository.localRepository.getDob();
        String anniversary= await coreRepository.localRepository.getAniversary();
        print('$userName,$email,$mobile,$image,$dob,$anniversary');
        emit(GetProfileSuccess(userName,email,mobile,image,dob,anniversary));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(UpdateProfileError(message));
    }
  }
}
