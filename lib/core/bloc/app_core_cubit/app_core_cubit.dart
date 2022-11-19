import 'dart:async';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core.dart';
part 'app_core_state.dart';

class AppCoreCubit extends Cubit<AppCoreState> {
  AppCoreCubit({required CoreRepository repository}) : super(AppCoreInitial()) {
    _repository = repository;
    _repository.eventBus.on<UserLoggedOutEvent>().listen((event) {
      // TODO : implement logout
    });
    _repository.eventBus.on<TimeOutEvent>().listen((event) {
      requestTimeOut();
    });
    locationSynced = false;
    locationSyncing = false;
    _repository.eventBus.on<ErrorAlertEvent>().listen((event) {
      _showAlertDialog(event.error);
    });
  }

  late final CoreRepository _repository;

  late bool locationSynced, locationSyncing;

  void checkUser() async {
    emit(AppCoreLoading());
    await Future.delayed(const Duration(seconds: 3));
    bool user = await _repository.localRepository.isLoggedIn();
    String profile = await _repository.localRepository.getProfileComplete();
    debugPrint('$user $profile');

      emit(AppCoreNavigateToLoginPage());

    // else if (profile.isEmpty) {
    //   // Home page
    //   emit(AppCoreNavigateToHomeScreen());
    // }
  }

  void requestTimeOut() {
    emit(AppCoreRequestTimeOut());
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    emit(AppCoreVersionState(version));
  }

  void _showAlertDialog(String error) async {
    emit(AppCoreInitial());
    await Future<void>.delayed(const Duration(milliseconds: 100));
    emit(AppCoreRequestError(error));
  }
}
