part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchSuccess extends SearchState {
  const SearchSuccess(this.response);

  final GetSearchProduct response;

  @override
  List<Object> get props => [response];
}

class SearchError extends SearchState {
  const SearchError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
