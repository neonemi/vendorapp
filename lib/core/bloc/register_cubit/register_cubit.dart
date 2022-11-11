
import 'package:flutter/material.dart';

import '../../core.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.coreRepository) : super(RegisterInitial());
  final CoreRepository coreRepository;

  void registerUser({
    required String mobile,
    required String name,
    required String email,
  }) async {
    emit(RegisterLoading());
    try {
      RegisterUserResponse registerUserResponse = await coreRepository.registerUser(mobile: mobile, name: name, email: email);
      emit(RegisterSuccess(registerUserResponse));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(RegisterError(message));
    }
  }
}
