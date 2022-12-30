import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendorapp/ui/ui.dart';

import '../../../../../core/core.dart';
import '../../../../core/controller/cart_controller.dart';
import '../../../../core/model/cart_data.dart';
import '../food_details/food_details_screen.dart';

class SearchProductScreen extends StatefulWidget {
  final List<searchData> productData;
  const SearchProductScreen({super.key, required this.productData});
  @override
  SearchProductScreenState createState() => SearchProductScreenState();
}

class SearchProductScreenState extends State<SearchProductScreen> {
  List<searchData>? productData;
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
    cartListString = context.read<LocalRepository>().getCartList() ?? '';
    setState(() {
      cartListString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // scrollDirection: Axis.vertical,
      itemCount: productData!.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        mainAxisExtent: 206,
        // childAspectRatio: MediaQuery.of(context).size.width /
        //     (MediaQuery.of(context).size.height ),
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => FoodDetailsScreen(
                  id: productData![index].id!,
                  orderId: productData![index].id!,
                  unitPrice: productData![index].price!,
                  price: productData![index].price!,
                  quantity: 1,
                  productId: productData![index].id!,
                  nameProduct: productData![index].name!,
                  imageProduct: productData![index].image!,
                  unitqty: productData![index].unitqty.toString(),
                  unitqtyname: productData![index].unitqtyname.toString(),
                  categoryName: productData![index].category.toString(),
                  gst: productData![index].categoryrelation!.gst.toString(),
                  isDiscounted: productData![index].isDiscounted.toString(),
                  discountedPrice:
                  productData![index].discountedPrice.toString(),
                )));
          },
          child: SizedBox(
              width: 160,
              // height: 300,
              // margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    //height: 150,
                    width: 160,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AppImageLoader(
                        imageUrl:
                        Apis.imageBaseUrl + productData![index].image!,
                        boxFit: BoxFit.cover,
                        height: 150,
                        width: 120,
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      productData![index].name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppTheme.appBlack, fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${StringConstant.rupeeSymbol}${productData![index].price!}',
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
                                  context.read<LocalRepository>().getCartList() ??
                                      '';
                              List<CartData>? cartList;
                              CartData? cartData;
                              if (cartListString != '') {
                                cartList = CartData.decode(cartListString);

                                cartDataList.value = cartList;

                                List<CartData> outputList = cartList
                                    .where((o) => o.id == productData![index].id)
                                    .toList();

                                if (outputList.isNotEmpty) {
                                  cartData = outputList.first;
                                } else {
                                  cartData = null;
                                }
                              }

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  if (cartData != null &&
                                      cartData.quantity! >= 1 &&
                                      cartData.id == productData![index].id)
                                    GestureDetector(
                                      onTap: () {
                                        if (kDebugMode) {
                                          print(cartData!.quantity);
                                        }
                                        cartController.counterRemoveProductToCart(
                                            context, cartData!);
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
                                  // if (cartData != null &&
                                  //     cartData.quantity! >= 1 &&
                                  //     cartData.id == productData![index].id)
                                  //   const SizedBox(
                                  //     width: 5,
                                  //   ),
                                  if (cartData != null &&
                                      cartData.quantity! >= 1 &&
                                      cartData.id == productData![index].id)
                                    Builder(builder: (context) {
                                      return Container(
                                          padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          margin:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                                          ));
                                    }),
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
                                          id: productData![index].id!,
                                          orderId: productData![index].id!,
                                          unitPrice: productData![index].price!,
                                          price: productData![index].price!,
                                          quantity: 1,
                                          productId: productData![index].id!,
                                          nameProduct: productData![index].name!,
                                          imageProduct: productData![index].image!,
                                          unitqty: productData![index]
                                              .unitqty
                                              .toString(),
                                          unitqtyname: productData![index]
                                              .unitqtyname
                                              .toString(),
                                          categoryName: productData![index]
                                              .category
                                              .toString(),
                                          gst: productData![index]
                                              .categoryrelation!
                                              .gst
                                              .toString(),
                                          isDiscounted: productData![index]
                                              .isDiscounted
                                              .toString(),
                                          discountedPrice: productData![index]
                                              .discountedPrice
                                              .toString(),
                                        );
                                        preference();
                                      }
                                    },
                                    child: Container(
                                        height: 20,
                                        width: 20,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: AppTheme.appRed),
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
