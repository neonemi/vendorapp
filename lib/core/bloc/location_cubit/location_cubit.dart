
import 'package:flutter/material.dart';

import '../../core.dart';

part 'location_state.dart';

class SearchLocationCubit extends Cubit<SearchLocationState> {
  SearchLocationCubit(this.coreRepository) : super(SearchLocationInitial());
  final CoreRepository coreRepository;

  void logout() async {
    emit(SearchLocationLoading());
    try {
      coreRepository.localRepository.clearDatabase();
      emit(SearchLocationSuccess());
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(SearchLocationError(message));
    }
  }

}
