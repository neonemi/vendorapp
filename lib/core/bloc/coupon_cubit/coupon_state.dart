part of 'coupon_cubit.dart';

abstract class CouponState extends Equatable {
  const CouponState();
}

class CouponInitial extends CouponState {
  @override
  List<Object> get props => [];
}

class CouponLoading extends CouponState {
  @override
  List<Object> get props => [];
}

class CouponSuccess extends CouponState {
  const CouponSuccess(this.response);

  final GetCouponResponse response;

  @override
  List<Object> get props => [response];
}


class CouponError extends CouponState {
  const CouponError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
