import 'package:flutter/foundation.dart';

import '../../core.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.coreRepository) : super(AddressInitial());
  final CoreRepository coreRepository;

  void addAddress(
      {
      required String address,
      required String location,
      required String lat,
      required String lng,
      required String floor,
      required String landmark,
      required String pincode}) async {
    emit(AddressLoading());
    try {
      String? userId = await coreRepository.localRepository.getUserId();
      if (kDebugMode) {
        print(userId);
      }
      SuccessResponse response = await coreRepository.addAddress(
          userid: userId!,
          address: address,
          location: location,
          lat: lat,
          lng: lng,
          floor: floor,
          landmark: landmark,
          pincode: pincode);
      emit(AddressSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(AddressError(message));
    }
  }

  void updateAddress(
      {
      required String address,
      required String location,
      required String lat,
      required String lng,
      required String floor,
      required String addressId}) async {
    emit(AddressLoading());
    try {
      String? userId = await coreRepository.localRepository.getUserId();
      if (kDebugMode) {
        print(userId);
      }
      SuccessResponse response = await coreRepository.updateAddress(
          userid: userId!,
          address: address,
          location: location,
          lat: lat,
          lng: lng,
          floor: floor,
          addressId: addressId);
      emit(UpdateAddressSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(AddressError(message));
    }
  }

  void defaultAddress(
      { required String addressId,required String location}) async {
    String? userId = await coreRepository.localRepository.getUserId();
    if (kDebugMode) {
      print(userId);
    }
    emit(AddressLoading());
    try {
      SuccessResponse response =
       await coreRepository.defaultAddress(
          addressId: addressId, userid: userId!);
      coreRepository.localRepository.setAddress(location);
      getAllAddress();
      emit(DefaultAddressSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(AddressError(message));
    }
  }

  void deleteAddress({required String addressId}) async {
    emit(AddressLoading());
    try {
      SuccessResponse response =
          await coreRepository.deleteAddress(addressId: addressId);
      getAllAddress();
      emit(DeleteAddressSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(AddressError(message));
    }
  }

  void getAllAddress() async {
    emit(AddressLoading());
    try {
      String? userId = await coreRepository.localRepository.getUserId();
      if (kDebugMode) {
        print(userId);
      }
      GetAllAddressResponse response =
      await coreRepository.getAllAddress(userId!);
      emit(AllAddressSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(AddressError(message));
    }
  }
}
