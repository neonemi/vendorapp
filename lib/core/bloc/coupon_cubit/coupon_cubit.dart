
import 'package:flutter/material.dart';

import '../../core.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit(this.coreRepository) : super(CouponInitial());
  final CoreRepository coreRepository;

  void getCoupon() async {
    emit(CouponLoading());
    try {
      GetCouponResponse response = await coreRepository.getCoupon();
      emit(CouponSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(CouponError(message));
    }
  }

}
