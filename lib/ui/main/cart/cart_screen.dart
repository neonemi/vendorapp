import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendorapp/core/core.dart';
import 'package:vendorapp/core/model/cart_data.dart';

import '../../../core/controller/cart_controller.dart';
import '../../ui.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartCubit _cubit;
  final cartController = Get.find<CartController>();
  int selectedIndex = 0;
  String cartListString = '';
  Future<void> preference() async {
    cartListString = context.read<LocalRepository>().getCartList() ?? '';
    setState(() {
      cartListString;
    });
  }

  @override
  void initState() {
    super.initState();
    // _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CartCubit>(create: (context) {
            _cubit = CartCubit(context.read<CoreRepository>());
            _cubit.loadData();
            return _cubit;
          }),
          // BlocProvider<CartCubit>(create: (context) {
          //   _cubit = CartCubit(context.read<CoreRepository>());
          //   _cubit.loadData();
          //   return _cubit;
          // }),
        ],
        child: BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state is CartLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
              if (state is CartSuccess) {}
              if (state is CartError) {
                context.showToast(state.message);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.appRed,
                centerTitle: true,
                elevation: 0.0,
                iconTheme: IconThemeData(color: AppTheme.appWhite),
                title: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Cart',
                    style: TextStyle(
                        color: AppTheme.appWhite,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: AppTheme.appRed,
                      // height: MediaQuery.of(context).size.height * 1 / 4,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Only one offer/coupon will be applicable on one order at a time.',
                              style: TextStyle(
                                  color: AppTheme.appWhite,
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.topLeft,
                            child: Text(
                              'DELIVERY AT',
                              style: TextStyle(
                                  color: AppTheme.appWhite,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                            if (state is CartSuccess) {
                              String currentLocation = state.address;
                              return Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          90,
                                      child: Text(currentLocation,
                                          style: TextStyle(
                                              color: AppTheme.appWhite,
                                              fontSize: 16,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: "Montserrat")),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      const AddressScreen()));
                                        },
                                        child: Container(
                                          child: Text('Change',
                                              style: TextStyle(
                                                  color: AppTheme.appWhite,
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: "Montserrat")),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 90,
                                    child: Text('NA',
                                        style: TextStyle(
                                            color: AppTheme.appWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: "Montserrat")),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text('ADD',
                                          style: TextStyle(
                                              color: AppTheme.appWhite,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: "Montserrat")),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    GetBuilder<CartController>(
                        // no need to initialize Controller ever again, just mention the type
                        builder: (value) {
                      var cartDataList = <CartData>[].obs;
                      cartListString =
                          context.read<LocalRepository>().getCartList() ?? '';
                      List<CartData> cartList = [];
                      CartData? cartData;
                      if (cartListString != '') {
                        cartList = CartData.decode(cartListString);

                        cartDataList.value = cartList;
                      }
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cartList!.length,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            List<CartData> outputList = cartList
                                .where((o) => o.id == cartList[index].id)
                                .toList();

                            if (outputList.isNotEmpty) {
                              cartData = outputList.first;
                            } else {
                              cartData = null;
                            }
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(cartList[index].name!,
                                          style: TextStyle(
                                              color: AppTheme.appBlack,
                                              fontSize: 16,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: "Montserrat"))),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("₹${cartList[index].price}",
                                              style: TextStyle(
                                                  color: AppTheme.appBlack,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: "Montserrat")),
                                          Container(
                                            margin: EdgeInsets.only(top: 20),
                                            height: 30,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (cartData != null &&
                                                    cartData!.quantity! >= 1 &&
                                                    cartData!.id ==
                                                        cartList[index].id!)
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (kDebugMode) {
                                                        print(
                                                            cartData!.quantity);
                                                      }
                                                      cartController
                                                          .counterRemoveProductToCart(
                                                              cartData!);
                                                      preference();
                                                    },
                                                    child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppTheme
                                                                    .appRed),
                                                        child: Icon(
                                                          Icons.remove,
                                                          color:
                                                              AppTheme.appBlack,
                                                          size: 15,
                                                        )),
                                                  ),
                                                if (cartData != null &&
                                                    cartData!.quantity! >= 1 &&
                                                    cartData!.id ==
                                                        cartList[index].id!)
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                if (cartData != null &&
                                                    cartData!.quantity! >= 1 &&
                                                    cartData!.id ==
                                                        cartList[index].id!)
                                                  Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        cartData != null
                                                            ? '${cartData!.quantity}'
                                                            : '',
                                                        style: TextStyle(
                                                            color:
                                                                AppTheme.appRed,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      if (cartData != null) {
                                                        if (kDebugMode) {
                                                          print('1 condition');
                                                        }
                                                        cartController
                                                            .counterAddProductToCart(
                                                                cartData!);
                                                        preference();
                                                        if (kDebugMode) {
                                                          print('3 condition');
                                                        }
                                                      } else {
                                                        if (kDebugMode) {
                                                          print(2);
                                                        }
                                                        cartController.addProductToCart(
                                                            id: cartList[index]
                                                                .id!,
                                                            orderId:
                                                                cartList[index]
                                                                    .id!,
                                                            unitPrice:
                                                                cartList[index]
                                                                    .price!,
                                                            price:
                                                                cartList[index]
                                                                    .price!,
                                                            quantity: 1,
                                                            productId:
                                                                cartList[index]
                                                                    .id!,
                                                            nameProduct:
                                                                cartList[index]
                                                                    .name!,
                                                            imageProduct:
                                                                cartList[index]
                                                                    .image!);
                                                        preference();
                                                      }
                                                    },
                                                    child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppTheme
                                                                    .appRed),
                                                        child: Icon(
                                                          Icons.add,
                                                          color:
                                                              AppTheme.appBlack,
                                                          size: 15,
                                                        )))
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            );
                          });
                    })
                  ],
                ),
              ),
            )));
  }

  //const Center(child: Text("profile",style: TextStyle(color: Colors.red),));

}
