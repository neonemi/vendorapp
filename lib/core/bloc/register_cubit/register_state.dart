part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess(this.registerUserResponse);

  final RegisterUserResponse registerUserResponse;

  @override
  List<Object> get props => [registerUserResponse];
}

class RegisterError extends RegisterState {
  const RegisterError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
