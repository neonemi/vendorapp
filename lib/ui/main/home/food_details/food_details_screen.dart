import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendorapp/core/model/cart_data.dart';

import '../../../../core/controller/cart_controller.dart';
import '../../../../core/core.dart';

class FoodDetailsScreen extends StatefulWidget {
  final int orderId;
  final int productId;
  final int unitPrice;
  final int quantity;
  final int price;
  final int id;
  final String nameProduct;
  final String imageProduct;
  final String unitqty;
  final String unitqtyname;
  final String categoryName;
  final String? gst;
  final String? isDiscounted;
  final String? discountedPrice;
  const FoodDetailsScreen({
    super.key,
    required this.id,
    required this.orderId,
    required this.unitPrice,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.nameProduct,
    required this.imageProduct,
    required this.unitqty,
    required this.unitqtyname,
    required this.categoryName,
    required this.discountedPrice,
    required this.isDiscounted,
    required this.gst,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}


class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int? orderId;
  int? productId;
  int? unitPrice;
  int? quantity;
  int? price;
  int? id;
  String? nameProduct;
  String? imageProduct;
  String? unitqty;
  String? unitqtyname;
  String? categoryName;
  final cartController = Get.find<CartController>();
  int selectedIndex = 0;
  String cartListString = '';
  String? gst;
  String? isDiscounted;
  String? discountedPrice;
  @override
  void initState() {
    super.initState();

    orderId = widget.orderId;
    productId = widget.productId;
    unitPrice = widget.unitPrice;
    quantity = widget.quantity;
    price = widget.price;
    id = widget.id;
    nameProduct = widget.nameProduct;
    imageProduct = widget.imageProduct;
    unitqty = widget.unitqty;
    unitqtyname = widget.unitqtyname;
    categoryName = widget.categoryName;
    gst=gst;
    isDiscounted=isDiscounted;
    discountedPrice=discountedPrice;
    if (kDebugMode) {
      print(orderId);
    }
    preference();
  }

  Future<void> preference() async {
    cartListString = context.read<LocalRepository>().getCartList() ?? '';
    setState(() {
      cartListString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appRed,
          iconTheme: IconThemeData(color: AppTheme.appWhite),
          centerTitle: true,
          elevation: 0.0,
          title: Container(
            margin: const EdgeInsets.only(right: 40),
            height: 50,
            alignment: Alignment.center,
            child: Text(
              'Detail',
              style: TextStyle(
                  color: AppTheme.appWhite,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontFamily: "Montserrat"),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: AppTheme.appRed,
              height: MediaQuery.of(context).size.height * 1 / 4,
              width: MediaQuery.of(context).size.width,
              child: Text(
                '$categoryName',
                style: TextStyle(
                  color: AppTheme.appWhite,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontFamily: "Montserrat",
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 1 / 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          Apis.imageBaseUrl + imageProduct!,
                        ),
                        fit: BoxFit.cover,
                      )),
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: MediaQuery.of(context).size.width * 2 / 3,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 1 / 12 +
                      MediaQuery.of(context).size.width * 2 / 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetBuilder<CartController>(
                    // no need to initialize Controller ever again, just mention the type
                      builder: (value) {
                        var cartDataList = <CartData>[].obs;
                        cartListString =
                            context.read<LocalRepository>().getCartList() ?? '';
                        List<CartData>? cartList;
                        CartData? cartData;
                        if (cartListString != '') {
                          cartList = CartData.decode(cartListString);

                          cartDataList.value = cartList;

                          List<CartData> outputList =
                          cartList.where((o) => o.id == id).toList();

                          if (outputList.isNotEmpty) {
                            cartData = outputList.first;
                          } else {
                            cartData = null;
                          }
                        }
                        return Container(
                          margin: const EdgeInsets.only(top: 20),
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (cartData != null &&
                                  cartData.quantity! >= 1 &&
                                  cartData.id == id)
                                GestureDetector(
                                  onTap: () {
                                    if (kDebugMode) {
                                      print(cartData!.quantity);
                                    }
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
                              // if (cartData != null &&
                              //     cartData.quantity! >= 1 &&
                              //     cartData.id == id)
                              //   const SizedBox(
                              //     width: 5,
                              //   ),
                              if (cartData != null &&
                                  cartData.quantity! >= 1 &&
                                  cartData.id == id)
                                Container(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppTheme.appRed,
                                        )),
                                    child: Text(
                                      cartData != null
                                          ? '${cartData.quantity}'
                                          : '',
                                      style: TextStyle(
                                          color: AppTheme.appRed,
                                          fontWeight: FontWeight.w600),
                                    )),
                              // const SizedBox(
                              //   width: 5,
                              // ),
                              GestureDetector(
                                  onTap: () {
                                    if (cartData != null) {
                                      if (kDebugMode) {
                                        print('1 condition');
                                      }
                                      cartController
                                          .counterAddProductToCart(cartData!);
                                      preference();
                                      if (kDebugMode) {
                                        print('3 condition');
                                      }
                                    } else {
                                      if (kDebugMode) {
                                        print(2);
                                      }
                                      cartController.addProductToCart(
                                          id: id!,
                                          orderId: id!,
                                          unitPrice: price!,
                                          price: price!,
                                          quantity: 1,
                                          productId: id!,
                                          nameProduct: nameProduct!,
                                          imageProduct: imageProduct!,
                                          unitqty: unitqty!,
                                          unitqtyname: unitqtyname!,
                                          categoryName: categoryName!, gst: gst!, isDiscounted: isDiscounted!, discountedPrice: discountedPrice!);
                                      preference();
                                    }
                                  },
                                  child: (cartData != null &&
                                      cartData.quantity! >= 1 &&
                                      cartData.id == id)
                                      ? Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      decoration:
                                      BoxDecoration(color: AppTheme.appRed),
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.appBlack,
                                        size: 15,
                                      ))
                                      : Container(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5),
                                    height: 30,
                                    decoration:
                                    BoxDecoration(color: AppTheme.appRed),
                                    child: Text(
                                      "ADD",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppTheme.appBlack),
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                            ],
                          ),
                        );
                      }),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        '$nameProduct ( $unitqty $unitqtyname)',
                        style: TextStyle(
                            color: AppTheme.appBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Text(
                        '$nameProduct',
                        style:
                        TextStyle(color: AppTheme.appBlack, fontSize: 14),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Text(
                        '₹$price',
                        style: TextStyle(
                            color: AppTheme.appRed,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * 1 /10 +MediaQuery.of(context).size.height * 1 /3 ),
            //   child: Text('${nameProduct}'),
            // )
          ],
        ));
    //const Center(child: Text("profile",style: TextStyle(color: Colors.red),));
  }
}
