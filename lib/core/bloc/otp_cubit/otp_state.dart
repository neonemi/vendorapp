part of 'otp_cubit.dart';

abstract class OtpState extends Equatable {
  const OtpState();
}

class OtpInitial extends OtpState {
  @override
  List<Object> get props => [];
}

class OtpLoading extends OtpState {
  @override
  List<Object> get props => [];
}

class OtpVerifyOTPSuccess extends OtpState {
  const OtpVerifyOTPSuccess(this.otpResponse);

  final OtpVerifyResponse otpResponse;

  @override
  List<Object> get props => [otpResponse];
}

class OtpVerifyOTPError extends OtpState {
  const OtpVerifyOTPError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
