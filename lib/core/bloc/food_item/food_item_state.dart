part of 'food_item_cubit.dart';

abstract class FoodItemState extends Equatable {
  const FoodItemState();
}

class FoodItemInitial extends FoodItemState {
  @override
  List<Object> get props => [];
}

class FoodItemLoading extends FoodItemState {
  @override
  List<Object> get props => [];
}

class FoodItemProductSuccess extends FoodItemState {
  const FoodItemProductSuccess(this.response);

  final FoodAllProduct response;

  @override
  List<Object> get props => [response];
}
class FoodFilterProductSuccess extends FoodItemState {
  const FoodFilterProductSuccess(this.response);

  final FoodAllProduct response;

  @override
  List<Object> get props => [response];
}
class FoodItemBestSellerSuccess extends FoodItemState {
  const FoodItemBestSellerSuccess(this.response);

  final GetBestSellerResponse response;

  @override
  List<Object> get props => [response];
}
class FoodSubCategorySuccess extends FoodItemState {
  const FoodSubCategorySuccess(this.response);

  final GetSubCategory response;

  @override
  List<Object> get props => [response];
}
class FoodItemError extends FoodItemState {
  const FoodItemError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
