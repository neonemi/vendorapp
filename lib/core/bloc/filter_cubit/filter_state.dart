part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  const FilterState();
}

class FilterInitial extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterLoading extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterSuccess extends FilterState {
  const FilterSuccess(this.response);

  final FilterResponse response;

  @override
  List<Object> get props => [response];
}

class FilterError extends FilterState {
  const FilterError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
