

import '../../core.dart';

part 'food_item_state.dart';

class FoodItemCubit extends Cubit<FoodItemState> {
  FoodItemCubit(this.coreRepository) : super(FoodItemInitial());
  final CoreRepository coreRepository;

  void getFoodProduct(String id,String sortBy,String type) async {
    emit(FoodItemLoading());
    try {
        FoodAllProduct response = await coreRepository.getFoodAllProduct(id,sortBy,type);
      emit(FoodItemProductSuccess(response));
      //getFoodBestSeller(id);
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(FoodItemError(message));
    }
  }
  void getFoodBestSeller(String id) async {
    emit(FoodItemLoading());
    try {
      GetBestSellerResponse response = await coreRepository.getFoodBestSeller(id);
      emit(FoodItemBestSellerSuccess(response));
      getFoodProduct(id, "", "");
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(FoodItemError(message));
    }
  }
  void getFoodFilterProduct(String id,String sortBy,String type) async {
    emit(FoodItemLoading());
    try {
      FoodAllProduct response = await coreRepository.getFoodProductFilter(id,sortBy,type);
      emit(FoodFilterProductSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(FoodItemError(message));
    }
  }
}
