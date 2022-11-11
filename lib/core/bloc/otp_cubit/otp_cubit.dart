

import '../../core.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.coreRepository) : super(OtpInitial());
  final CoreRepository coreRepository;

  void verifyOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(OtpLoading());
    try {
      OtpVerifyResponse otpResponse = await coreRepository.verifyOTP(mobile: phoneNumber,otp:otp);
      coreRepository.localRepository.setUserId(otpResponse.data!.id.toString());
      coreRepository.localRepository.setUserName(otpResponse.data!.name.toString());
      coreRepository.localRepository.setUserEmail(otpResponse.data!.email.toString());
      coreRepository.localRepository.saveToken(otpResponse.data!.token.toString());
      coreRepository.localRepository.setLogin(true);
      coreRepository.localRepository.setProfileComplete("isYes");
      coreRepository.localRepository.setMobile(otpResponse.data!.mobile.toString());
      emit(OtpVerifyOTPSuccess(otpResponse));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(OtpVerifyOTPError(message));
    }
  }
}
