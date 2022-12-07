import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/controller/cart_controller.dart';
import '../../../../../core/core.dart';
import '../../../../../core/hive/hive_functions.dart';
import '../../../../../core/model/cart_data.dart';
import '../../../../ui.dart';

class FoodAllProductScreen extends StatefulWidget {
  final List<ProductListData> productData;
  const FoodAllProductScreen({super.key, required this.productData});
  @override
  FoodAllProductScreenState createState() => FoodAllProductScreenState();
}

class FoodAllProductScreenState extends State<FoodAllProductScreen> {
  List<ProductListData>? productData;

  final cartController = Get.find<CartController>();
  int selectedIndex = 0;
  String cartListString = '';
  @override
  void initState() {
    super.initState();
    productData = widget.productData;
    preference();
  }

  Future<void> preference() async {
    cartListString = context.read<LocalRepository>().getCartList()! ?? '';
    setState(() {
      cartListString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productData!.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => {},
          child: Container(
              width: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //height: 150,
                    width: 160,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AppImageLoader(
                        imageUrl:
                            Apis.imageBaseUrl + productData![index].image!,
                        boxFit: BoxFit.cover,
                        height: 100,
                        width: 120,
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      productData![index].name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppTheme.appBlack, fontSize: 14),
                    ),
                  ),
                  Container(
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '₹${productData![index].price!}',
                              style: TextStyle(
                                  color: AppTheme.appRed,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )),
                        GetBuilder<CartController>(
                            // no need to initialize Controller ever again, just mention the type
                            builder: (value) {
                          var cartDataList = <CartData>[].obs;
                          cartListString =
                              context.read<LocalRepository>().getCartList()! ??
                                  '';
                          List<CartData>? cartList;
                          CartData? cartData;
                          if (cartListString != '') {
                            cartList = CartData.decode(cartListString);

                            cartDataList.value = cartList;
                            //print(cartList);

                            List<CartData> outputList = cartList
                                .where((o) => o.id == productData![index].id)
                                .toList();
                            if (outputList.isNotEmpty) {
                              // print('output${outputList.first.id}');
                              // print(123);
                              // if (outputList.first.quantity! >=
                              //     outputList.last.quantity!) {
                                cartData = outputList.first;
                              // }
                              // else {
                              //   cartData = outputList.last;
                              // }
                            }

                            // print('output cart'+cartData!.quantity.toString());
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (cartData != null &&
                                  cartData!.quantity! >= 1 &&
                                  cartData!.id == productData![index].id)
                                GestureDetector(
                                  onTap: () {
                                    print(cartData!.quantity);
                                    cartController
                                        .counterRemoveProductToCart(cartData!);
                                    preference();
                                  },
                                  child: Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      decoration:
                                          BoxDecoration(color: AppTheme.appRed),
                                      child: Icon(
                                        Icons.remove,
                                        color: AppTheme.appBlack,
                                        size: 15,
                                      )),
                                ),
                              if (cartData != null &&
                                  cartData!.quantity! >= 1 &&
                                  cartData!.id == productData![index].id)
                                const SizedBox(
                                  width: 5,
                                ),
                              if (cartData != null &&
                                  cartData!.quantity! >= 1 &&
                                  cartData!.id == productData![index].id)
                                Builder(builder: (context) {
                                  return Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        cartData != null
                                            ? '${cartData!.quantity}'
                                            : '',
                                        style: TextStyle(
                                            color: AppTheme.appRed,
                                            fontWeight: FontWeight.w600),
                                      ));
                                }),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // print(cartData);
                                  if (cartData != null) {
                                    print(1);
                                    print(cartData!.quantity);
                                    print(cartData!.quantity);
                                    //if(cartData!.id==productData![index].id) {
                                    print(3);
                                    if(cartData.quantity! >= 1) {
                                      cartController
                                          .counterAddProductToCart(cartData!);
                                    }else{
                                         cartController.addProductToCart(id: productData![index]!.id!, orderId: productData![index]!.id!, unitPrice: productData![index]!.price!, price: productData![index]!.price!, quantity: 1, productId: productData![index]!.id!, nameProduct: productData![index]!.name!, imageProduct: productData![index]!.image!);

                                    }
                                    // }else{
                                    //    print(4);
                                    //    cartController.addProductToCart(id: productData![index]!.id!, orderId: productData![index]!.id!, unitPrice: productData![index]!.price!, price: productData![index]!.price!, quantity: 1, productId: productData![index]!.id!, nameProduct: productData![index]!.name!, imageProduct: productData![index]!.image!);
                                    //
                                    //  }
                                  } else {
                                    print(2);
                                    cartController.addProductToCart(
                                        id: productData![index]!.id!,
                                        orderId: productData![index]!.id!,
                                        unitPrice: productData![index]!.price!,
                                        price: productData![index]!.price!,
                                        quantity: 1,
                                        productId: productData![index]!.id!,
                                        nameProduct: productData![index]!.name!,
                                        imageProduct:
                                            productData![index]!.image!);
                                  }
                                  preference();
                                },
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    alignment: Alignment.center,
                                    decoration:
                                        BoxDecoration(color: AppTheme.appRed),
                                    child: Icon(
                                      Icons.add,
                                      color: AppTheme.appBlack,
                                      size: 15,
                                    )),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
