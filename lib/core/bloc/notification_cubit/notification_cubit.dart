
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.coreRepository) : super(NotificationInitial());
  final CoreRepository coreRepository;

  void getNotifications() async {

    emit(NotificationLoading());
    try {
      String? userId=await coreRepository.localRepository.getUserId();
      if (kDebugMode) {
        print(userId);
      }
      GetNotificationResponse response = await coreRepository.getNotifications(userId!);
      emit(NotificationSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(NotificationError(message));
    }
  }
  void deleteNotifications() async {

    emit(NotificationLoading());
    try {
      String? userId=await coreRepository.localRepository.getUserId();
      if (kDebugMode) {
        print(userId);
      }
      GetNotificationResponse response = await coreRepository.deleteNotifications(userId!);
      emit(NotificationDeleteSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(NotificationError(message));
    }
  }
  void readNotifications() async {
    emit(NotificationLoading());
    try {
      String? userId = await coreRepository.localRepository.getUserId();
      if (kDebugMode) {
        print(userId);
      }
      GetNotificationResponse response = await coreRepository.readNotifications(
          userId!);
      emit(NotificationReadSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(NotificationError(message));
    }
  }
  void unReadCountNotifications() async {

    emit(NotificationLoading());
    try {
      String? userId=await coreRepository.localRepository.getUserId();
      if (kDebugMode) {
        print(userId);
      }
      GetUnReadNotificationCount response = await coreRepository.unReadCountNotifications(userId!);
      emit(NotificationUnReadSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(NotificationError(message));
    }
  }
}
