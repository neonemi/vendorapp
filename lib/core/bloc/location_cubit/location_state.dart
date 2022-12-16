part of 'location_cubit.dart';

abstract class SearchLocationState extends Equatable {
  const SearchLocationState();
}

class SearchLocationInitial extends SearchLocationState {
  @override
  List<Object> get props => [];
}

class SearchLocationLoading extends SearchLocationState {
  @override
  List<Object> get props => [];
}

class SearchLocationSuccess extends SearchLocationState {
  @override
  List<Object> get props => [];
}


class SearchLocationError extends SearchLocationState {
  const SearchLocationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
