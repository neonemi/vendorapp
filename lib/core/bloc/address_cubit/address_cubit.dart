
import 'package:flutter/material.dart';

import '../../core.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.coreRepository) : super(AddressInitial());
  final CoreRepository coreRepository;

  void sendOTP({
    required String phoneNumber,
  }) async {
    emit(AddressLoading());
    try {
      OtpResponse response = await coreRepository.sendOTP(mobile: phoneNumber);
      emit(AddressSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(AddressError(message));
    }
  }
}
