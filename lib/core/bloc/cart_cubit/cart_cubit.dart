
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:vendorapp/core/model/cart_data.dart';

import '../../core.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.coreRepository) : super(CartInitial());
  final CoreRepository coreRepository;
  var cartDataList = <CartData>[].obs;
  // late SharedPreferences storge;
  String cartListString = '';
  void loadData() async {
    emit(CartLoading());
    try {
      String address= await _getLocation();
      emit(CartSuccess(address));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(CartError(message));
    }
  }
  Future<String> _getLocation() async {
    String address= await coreRepository.localRepository.getAddress();
    String currentLocation ='';
    if(address.isEmpty) {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      debugPrint('location: ${position.latitude}');
      List<Placemark> addresses =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      var first = addresses.first;
      currentLocation =
          "${first.name} ${first.subLocality} ${first.locality} ${first.administrativeArea} ${first.country} ${first.postalCode}";
      coreRepository.localRepository.setAddress(currentLocation);
    }else{
      currentLocation =address;
    }
    return currentLocation ;
  }

  Future<List<CartData>>  cartData() async {
    String cartListString=  coreRepository.localRepository.getCartList();
    if (cartListString != '') {
      final List<CartData> cartList = CartData.decode(cartListString);
      cartDataList.value = cartList;
      return cartList;
    }else{
      return [];
    }
  }

}
