import 'package:flutter/material.dart';

import '../../core.dart';

part 'food_details_state.dart';

class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  FoodDetailsCubit(this.coreRepository) : super(FoodDetailsInitial());
  final CoreRepository coreRepository;

  void getFoodDetails() async {
    emit(FoodDetailsLoading());
    try {
      FilterResponse response = await coreRepository.getFilter();
      emit(FoodDetailsSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(FoodDetailsError(message));
    }
  }
}
