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


class CartError extends CartState {
  const CartError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
