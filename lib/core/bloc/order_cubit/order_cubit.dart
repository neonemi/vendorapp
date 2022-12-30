
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.coreRepository) : super(OrderInitial());
  final CoreRepository coreRepository;

  void getOrder() async {
    emit(OrderLoading());
    try {
      String? mobile = await coreRepository.localRepository.getMobile();
      print(mobile);
      GetCustomerOrderResponse response = await coreRepository.customerOrders(mobile: mobile!);
      emit(OrderSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(OrderError(message));
    }
  }

  void getTrackOrder(String orderId) async {

    emit(OrderLoading());
    try {
      GetTrackOrderResponse response = await coreRepository.trackOrders(orderId: orderId);
      emit(OrderTrackSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(OrderError(message));
    }
  }
}
