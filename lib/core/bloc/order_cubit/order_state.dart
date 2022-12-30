part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderSuccess extends OrderState {
  const OrderSuccess(this.response);
  final GetCustomerOrderResponse response;
  @override
  List<Object> get props => [response];
}

class OrderTrackSuccess extends OrderState {
  const OrderTrackSuccess(this.message);
  final GetTrackOrderResponse message;
  @override
  List<Object> get props => [message];
}

class OrderError extends OrderState {
  const OrderError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
