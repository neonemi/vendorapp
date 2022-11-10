import 'dart:async';


import 'package:flutter/services.dart';

import '../../core.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(const ConnectivityInitial()) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initConnectivity();
  }

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      emit(ConnectivityOffline(connectivityResult: result));
    } else {
      if (state.connectivityResult == ConnectivityResult.none) {
        emit(ConnectivityRestored(connectivityResult: result));
        await Future.delayed(const Duration(seconds: 5));
        emit(ConnectivityOnline(connectivityResult: result));
      } else {
        emit(ConnectivityOnline(connectivityResult: result));
      }
    }
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }
    return _updateConnectionStatus(result);
  }
}
