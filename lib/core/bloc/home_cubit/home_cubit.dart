

import '../../core.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.coreRepository) : super(HomeInitial());
  final CoreRepository coreRepository;

  void getBannerImage() async {
    emit(HomeLoading());
    try {
      GetBannerImage response = await coreRepository.getBannerImage();
      emit(HomeSuccess(response));
      getFoodCategory();
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(HomeError(message));
    }
  }

  void getFoodCategory() async {
    emit(HomeLoading());
    try {
      GetFoodCategory response = await coreRepository.getFoodCategory();
      emit(HomeCategorySuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(HomeError(message));
    }
  }
}
