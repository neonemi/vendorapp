
import '../../core.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(this.coreRepository) : super(FilterInitial());
  final CoreRepository coreRepository;

  void getFilter() async {
    emit(FilterLoading());
    try {
      FilterResponse response = await coreRepository.getFilter();
      emit(FilterSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(FilterError(message));
    }
  }
}
