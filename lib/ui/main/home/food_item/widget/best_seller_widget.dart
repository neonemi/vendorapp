import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendorapp/core/core.dart';
import 'package:vendorapp/ui/ui.dart';
import '../../../../../core/controller/cart_controller.dart';
import '../../../../../core/model/cart_data.dart';
import '../../food_details/food_details_screen.dart';

class FoodBestSellerList extends StatefulWidget {
  final List<BestSellerData> bestSellerData;
  final String itemName;
  const FoodBestSellerList({super.key, required this.bestSellerData,required this.itemName});
  @override
  FoodBestSellerListState createState() => FoodBestSellerListState();
}

class FoodBestSellerListState extends State<FoodBestSellerList> {
  List<BestSellerData>? bestSellerData;
  String? itemName;
  final cartController = Get.find<CartController>();
  int selectedIndex = 0;
  String cartListString = '';
  @override
  void initState() {
    super.initState();
    bestSellerData = widget.bestSellerData;
    itemName=widget.itemName;
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
    return SizedBox(
      height: 220,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bestSellerData!.length,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (kDebugMode) {
                  print(bestSellerData![index].id!);
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => FoodDetailsScreen(
                          id: bestSellerData![index].id!,
                          orderId: bestSellerData![index].id!,
                          unitPrice: bestSellerData![index].price!,
                          price: bestSellerData![index].price!,
                          quantity: 1,
                          productId: bestSellerData![index].id!,
                          nameProduct: bestSellerData![index].name!,
                          imageProduct: bestSellerData![index].image!,
                          unitqty: bestSellerData![index].unitqty.toString(),
                          unitqtyname:
                              bestSellerData![index].unitqtyname.toString(), categoryName: itemName!,
                        )));
              },
              child: Container(
                width: 160,
                // height: 210,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AppImageLoader(
                          imageUrl:
                              Apis.imageBaseUrl + bestSellerData![index].image!,
                          boxFit: BoxFit.cover,
                          height: 110,
                          width: 110,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 160,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          bestSellerData![index].name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: AppTheme.appBlack, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: GetBuilder<CartController>(
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

                          List<CartData> outputList = cartList
                              .where((o) => o.id == bestSellerData![index].id)
                              .toList();

                          if (outputList.isNotEmpty) {
                            cartData = outputList.first;
                          } else {
                            cartData = null;
                          }
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '₹${bestSellerData![index].price!}',
                                  style: TextStyle(
                                      color: AppTheme.appRed,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (cartData != null &&
                                    cartData.quantity! >= 1 &&
                                    cartData.id == bestSellerData![index].id)
                                  GestureDetector(
                                    onTap: () {
                                      if (kDebugMode) {
                                        print(cartData!.quantity);
                                      }
                                      cartController.counterRemoveProductToCart(
                                          cartData!);
                                      preference();
                                    },
                                    child: Container(
                                        height: 20,
                                        width: 20,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: AppTheme.appRed),
                                        child: Icon(
                                          Icons.remove,
                                          color: AppTheme.appBlack,
                                          size: 15,
                                        )),
                                  ),
                                if (cartData != null &&
                                    cartData.quantity! >= 1 &&
                                    cartData.id == bestSellerData![index].id)
                                  const SizedBox(
                                    width: 5,
                                  ),
                                if (cartData != null &&
                                    cartData.quantity! >= 1 &&
                                    cartData.id == bestSellerData![index].id)
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        cartData != null
                                            ? '${cartData.quantity}'
                                            : '',
                                        style: TextStyle(
                                            color: AppTheme.appRed,
                                            fontWeight: FontWeight.w600),
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
                                          .counterAddProductToCart(cartData);
                                      preference();
                                      if (kDebugMode) {
                                        print('3 condition');
                                      }
                                    } else {
                                      if (kDebugMode) {
                                        print(2);
                                      }
                                      cartController.addProductToCart(
                                          id: bestSellerData![index].id!,
                                          orderId: bestSellerData![index].id!,
                                          unitPrice:
                                              bestSellerData![index].price!,
                                          price: bestSellerData![index].price!,
                                          quantity: 1,
                                          productId: bestSellerData![index].id!,
                                          nameProduct:
                                              bestSellerData![index].name!,
                                          imageProduct:
                                              bestSellerData![index].image!);
                                      preference();
                                    }
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
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
