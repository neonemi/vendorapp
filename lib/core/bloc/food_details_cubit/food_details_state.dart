part of 'food_details_cubit.dart';

abstract class FoodDetailsState extends Equatable {
  const FoodDetailsState();
}

class FoodDetailsInitial extends FoodDetailsState {
  @override
  List<Object> get props => [];
}

class FoodDetailsLoading extends FoodDetailsState {
  @override
  List<Object> get props => [];
}

class FoodDetailsSuccess extends FoodDetailsState {
  const FoodDetailsSuccess(this.response);

  final FilterResponse response;

  @override
  List<Object> get props => [response];
}

class FoodDetailsError extends FoodDetailsState {
  const FoodDetailsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
