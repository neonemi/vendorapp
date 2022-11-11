
import 'package:flutter/material.dart';

import '../../core.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.coreRepository) : super(LoginInitial());
  final CoreRepository coreRepository;

  void sendOTP({
    required String phoneNumber,
  }) async {
    emit(LoginLoading());
    try {
      OtpResponse response = await coreRepository.sendOTP(mobile: phoneNumber);
      emit(LoginSendOTPSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(LoginSendOTPError(message));
    }
  }
}
