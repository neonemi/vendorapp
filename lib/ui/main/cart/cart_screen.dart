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
  String address='';
  bool login = false;
  Future<void> preference() async {
    cartListString = context.read<LocalRepository>().getCartList() ?? '';
    setState(() {
      cartListString;
    });
  }

  @override
  void initState() {
    super.initState();
    getaddress();

  }
  Future<void> getaddress() async {
    address= await _getLocation();
    setState((){
      address;
    });
    // if(address.isNotEmpty){
    //   preference();
    // }
  }
  Future<String> _getLocation() async {
    String address1= await context.read<LocalRepository>().getAddress();
    String currentLocation ='';
    if(address1.isEmpty) {
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
      context.read<LocalRepository>().setAddress(currentLocation);
    }else{
      currentLocation =address1;
    }
    return currentLocation ;
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
          if(state is CartOrderPlacedSuccess){
            GetOrderResponse response=state.orderResponse;
            AlertExtension(context).showPaymentMethodDialog(
                onPayNow: () {

                  // _cubit.paymentPayload(response.orderId.toString(), 'xyz', response.paymentStatus!);
                  _cubit.paymentPayload(response.orderId.toString(), 'xyz', 'success');
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => const OrderHistoryScreen(
                  //           showAppBar: true,
                  //         )));
                },
                onCashDelivery: (){

                });
          }

          if(state is CartLoginError){
            AlertExtension(context).showSuccessAlert(message: StringConstant.pleaseRegisterLogin,cancelTextButton: StringConstant.no,confirmTextButton: StringConstant.yes,onConfirm: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
              ), (e) => false);
            }, height: 150, width: MediaQuery.of(context).size.width-40, title: '');
          }
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
                StringConstant.cart,
                style: TextStyle(
                    color: AppTheme.appWhite,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontFamily: StringConstant.fontFamily),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {


            return GetBuilder<CartController>(
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

                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              color: AppTheme.appRed,
                              height: MediaQuery.of(context).size.height * 1 / 5,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      StringConstant.onlyOneOffer,
                                      style: TextStyle(
                                          color: AppTheme.appWhite,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: StringConstant.fontFamily),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      StringConstant.deliveryAt,
                                      style: TextStyle(
                                          color: AppTheme.appWhite,
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: StringConstant.fontFamily),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                          MediaQuery.of(context).size.width -
                                              90,
                                          child: Text(address.isEmpty?'NA':address,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: AppTheme.appWhite,
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: StringConstant.fontFamily)),
                                        ),
                                        if(address.isNotEmpty)
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                        context) =>
                                                        const AddressScreen()));
                                              },
                                              child: Text(StringConstant.change,
                                                  style: TextStyle(
                                                      color: AppTheme.appWhite,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
                                                      fontFamily: StringConstant.fontFamily)),
                                            ),
                                          ),
                                        if(address.isEmpty)
                                          Expanded(
                                            child: Container(
                                              child: Text(StringConstant.add,
                                                  style: TextStyle(
                                                      color: AppTheme.appWhite,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      fontStyle: FontStyle.normal,
                                                      fontFamily: StringConstant.fontFamily)),
                                            ),
                                          )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 1 / 4,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: cartList.length,
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            title: Text(
                                                '${cartList[index].name!} ${cartList[index].unitqty!=null?( '(${cartList[index].unitqty} ${cartList[index].unitqtyname})'):''}',
                                                style: TextStyle(
                                                    color: AppTheme.appBlack,
                                                    fontSize: 16,
                                                    fontStyle: FontStyle.normal,
                                                    fontFamily: StringConstant.fontFamily)),
                                            subtitle: Text(
                                                "${StringConstant.rupeeSymbol}${cartList[index].price}",
                                                style: TextStyle(
                                                    color: AppTheme.appBlack,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.normal,
                                                    fontFamily: StringConstant.fontFamily)),
                                            trailing: Container(
                                              margin:
                                              const EdgeInsets.only(top: 20),
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
                                                            context,
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
                                                  // const SizedBox(
                                                  //   width: 5,
                                                  // ),
                                                    if (cartData != null &&
                                                        cartData!.quantity! >=
                                                            1 &&
                                                        cartData!.id ==
                                                            cartList[index].id!)
                                                      Container(
                                                          padding:
                                                          const EdgeInsets.fromLTRB(
                                                              5, 0, 5, 0),
                                                          margin: const EdgeInsets
                                                              .fromLTRB(
                                                              0, 5, 0, 5),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration:
                                                          BoxDecoration(
                                                              border:
                                                              Border.all(
                                                                color: AppTheme
                                                                    .appRed,
                                                              )),
                                                          child: Text(
                                                            cartData != null
                                                                ? '${cartData!.quantity}'
                                                                : '',
                                                            style: TextStyle(
                                                                color: AppTheme
                                                                    .appRed,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                              orderId: cartList[index]
                                                                  .id!,
                                                              unitPrice: cartList[index]
                                                                  .price!,
                                                              price: cartList[index]
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
                                                                  .image!,
                                                              unitqty: cartList[index]
                                                                  .unitqty!,
                                                              unitqtyname:
                                                              cartList[index]
                                                                  .unitqtyname!,
                                                              categoryName:
                                                              cartList[index]
                                                                  .categoryName!,
                                                              gst: cartList[index]
                                                                  .gst!,
                                                              isDiscounted:
                                                              cartList[index]
                                                                  .isDiscounted!,
                                                              discountedPrice:
                                                              cartList[index]
                                                                  .discountedPrice!);
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
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            if(cartList.isNotEmpty)
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 1 / 4,
                                child: Column(
                                  children: [
                                    ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      title: Text(StringConstant.itemTotal,
                                          style: TextStyle(
                                              color: AppTheme.appBlack,
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: StringConstant.fontFamily)),
                                      trailing: Text('${StringConstant.rupeeSymbol}${cartController.cartTotalPrice()}',
                                          style: TextStyle(
                                              color: AppTheme.appBlack,
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: StringConstant.fontFamily)),
                                    ),
                                    ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      title: Text(StringConstant.gst,
                                          style: TextStyle(
                                              color: AppTheme.appBlack,
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: StringConstant.fontFamily)),
                                      trailing: Text('${StringConstant.rupeeSymbol}${cartController.gstPrice()}',
                                          style: TextStyle(
                                              color: AppTheme.appBlack,
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: StringConstant.fontFamily)),
                                    ),
                                    ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      minLeadingWidth: 0,
                                      title: Text(StringConstant.deliveryCharge,
                                          style: TextStyle(
                                              color: AppTheme.appBlack,
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: StringConstant.fontFamily)),
                                      trailing: Text('${StringConstant.rupeeSymbol}0.00',
                                          style: TextStyle(
                                              color: AppTheme.appBlack,
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              fontFamily:StringConstant.fontFamily)),
                                    ),
                                    ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      title: Text(StringConstant.applyCoupon,
                                          style: TextStyle(
                                              color: AppTheme.appRed,
                                              fontSize: 16,
                                              decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: StringConstant.fontFamily)),
                                      onTap: (){
                                        _onApplyCoupon(context);
                                      },
                                    ),
                                    Divider(
                                      color: AppTheme.appGrey,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      minLeadingWidth: 0,
                                      title: Text(StringConstant.grandTotal,
                                          style: TextStyle(
                                              color: AppTheme.appBlack,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: StringConstant.fontFamily)),
                                      trailing: Text('${StringConstant.rupeeSymbol}${cartController.grandTotalPrice(cartController.cartTotalPrice(),cartController.gstPrice())}',
                                          style: TextStyle(
                                              color: AppTheme.appBlack,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: StringConstant.fontFamily)),
                                    ),
                                  ],
                                ),
                              ),
                            if(cartList.isNotEmpty)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 200,
                                  child: ListTile(
                                    dense: true,
                                    tileColor: AppTheme.appRed,
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    minLeadingWidth: 0,
                                    title: Text(StringConstant.total,
                                        style: TextStyle(
                                            color: AppTheme.appWhite,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: StringConstant.fontFamily)),
                                    subtitle: Text('${StringConstant.rupeeSymbol}${cartController.grandTotalPrice(cartController.cartTotalPrice(),cartController.gstPrice())}',
                                        style: TextStyle(
                                            color: AppTheme.appWhite,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: StringConstant.fontFamily)),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(StringConstant.placeOrder,
                                            style: TextStyle(
                                                color: AppTheme.appWhite,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: StringConstant.fontFamily)),
                                        Icon(
                                          Icons.arrow_right,
                                          color: AppTheme.appWhite,
                                          size: 22,
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      _onTap(context, address,'${cartController.grandTotalPrice(cartController.cartTotalPrice(),cartController.gstPrice())}','${cartController.cartTotalPrice()}','');
                                    },
                                  ),
                                ),
                              )
                          ]));
                });


          }),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, String currentLocation,String finalamount,String cartAmount,String coupon) {
    AlertExtension(context).showPlaceOrderAlert(
        address: currentLocation,
        onProceed: () {
          _cubit.placeOrder(cartAmount, coupon, finalamount);


          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (BuildContext context) => const OrderHistoryScreen(
          //           showAppBar: true,
          //         )));
        },
        onAddressChange: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const AddressScreen()));
        });
  }

  void _onApplyCoupon(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
        const CouponScreen()));
  }


}
