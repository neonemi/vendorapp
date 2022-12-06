
import 'package:flutter/material.dart';

import '../../core.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.coreRepository) : super(SearchInitial());
  final CoreRepository coreRepository;

  void getSearchProduct({
    required String text,
  }) async {
    emit(SearchLoading());
    try {
      GetSearchProduct response = await coreRepository.getSearchProduct(text: text);
      emit(SearchSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(SearchError(message));
    }
  }
}
