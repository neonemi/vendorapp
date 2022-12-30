
import 'dart:convert';

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

  void placeOrder(
   String cartamount,
   String coupon,
   String finalamount) async {
    emit(CartLoading());
    try {
      String? mobile = await coreRepository.localRepository.getMobile();
      String? name = await coreRepository.localRepository.getUserName();
      String? address = await coreRepository.localRepository.getAddress();
      bool? login =await coreRepository.localRepository.isLoggedIn();
      print(name);
      print(mobile);
      print(address);
      String productListString = coreRepository.localRepository.getProductList() ?? '';
      print(productListString);
      if(login==true){
        GetOrderResponse response = await coreRepository.order(
            mobile: mobile!,
            name: name,
            address: address!,
            products: productListString,
            cartamount: cartamount,
            coupon: coupon,
            finalamount: finalamount);
        print(jsonEncode(response));
        // {"status":200,"message":"Order Created Successfully","order_id":531,"payment_status":"pending"}
        emit(CartOrderPlacedSuccess(response));
      }else{
        emit(CartLoginError());
      }
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
     emit(CartError(message));
    }
  }

  void paymentPayload(
      String orderId,
      String transactionId,
      String paymentStatus) async {
    emit(CartLoading());
    try {
      //product array add qty
      String? userId = await coreRepository.localRepository.getUserId();
      GetPaymentPayloadResponse response = await coreRepository.paymentPayload(orderId: orderId, userId: userId!, transactionId: transactionId, paymentStatus: paymentStatus);
      emit(CartPaymentPayloadSuccess(response));
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(CartError(message));
    }
  }
}
