import '../../core.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.coreRepository) : super(AddressInitial());
  final CoreRepository coreRepository;

  void addAddress(
      {required String userid,
      required String address,
      required String location,
      required String lat,
      required String lng,
      required String floor,
      required String landmark,
      required String pincode}) async {
    emit(AddressLoading());
    try {
      SuccessResponse response = await coreRepository.addAddress(
          userid: userid,
          address: address,
          location: location,
          lat: lat,
          lng: lng,
          floor: floor,
          landmark: landmark,
          pincode: pincode);
      emit(AddressSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(AddressError(message));
    }
  }

  void updateAddress(
      {required String userid,
      required String address,
      required String location,
      required String lat,
      required String lng,
      required String floor,
      required String addressId}) async {
    emit(AddressLoading());
    try {
      SuccessResponse response = await coreRepository.updateAddress(
          userid: userid,
          address: address,
          location: location,
          lat: lat,
          lng: lng,
          floor: floor,
          addressId: addressId);
      emit(UpdateAddressSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(AddressError(message));
    }
  }

  void defaultAddress(
      {required String userid, required String addressId}) async {
    emit(AddressLoading());
    try {
      SuccessResponse response = await coreRepository.defaultAddress(
          addressId: addressId, userid: userid);
      emit(DefaultAddressSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(AddressError(message));
    }
  }

  void deleteAddress({required String addressId}) async {
    emit(AddressLoading());
    try {
      SuccessResponse response =
          await coreRepository.deleteAddress(addressId: addressId);
      emit(DeleteAddressSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(AddressError(message));
    }
  }
}
