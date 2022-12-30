part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartSuccess extends CartState {
  const CartSuccess(this.address);

  final String address;
  @override
  List<Object> get props => [address];
}

class CartLoginError extends CartState {
  @override
  List<Object> get props => [];
}

class CartOrderPlacedSuccess extends CartState {
  const CartOrderPlacedSuccess(this.orderResponse);

  final GetOrderResponse orderResponse;

  @override
  List<Object> get props => [orderResponse];
}

class CartPaymentPayloadSuccess extends CartState {
  const CartPaymentPayloadSuccess(this.orderResponse);

  final GetPaymentPayloadResponse orderResponse;
  @override
  List<Object> get props => [orderResponse];
}

class CartError extends CartState {
  const CartError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
