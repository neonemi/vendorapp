part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSuccess extends HomeState {
  const HomeSuccess(this.response);

  final GetBannerImage response;

  @override
  List<Object> get props => [response];
}
class HomeCategorySuccess extends HomeState {
  const HomeCategorySuccess(this.response);

  final GetFoodCategory response;

  @override
  List<Object> get props => [response];
}
class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
