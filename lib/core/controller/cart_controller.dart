import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/core.dart';

import '../model/cart_data.dart';

class CartController extends GetxController {
  CartController({required this.localRepository});
  var cartDataList = <CartData>[].obs;
  var productDataList = <ProductArray>[].obs;
  // late SharedPreferences storge;
  String cartListString = '';
  String productListString = '';
  final LocalRepository localRepository;
  @override
  void onInit() async {
    cartListString = localRepository.getCartList() ?? '';
    if (cartListString != '') {
      final List<CartData> cartList = CartData.decode(cartListString);

      cartDataList.value = cartList;
    }
    productListString = localRepository.getCartList() ?? '';
    if (productListString != '') {
      final List<ProductArray> productList =
      ProductArray.decode(productListString);

      productDataList.value = productList;
    }
    super.onInit();
  }

  void addProductToCart(
      {required int id,
        required int orderId,
        required int unitPrice,
        required int price,
        required int quantity,
        required int productId,
        required String nameProduct,
        required String imageProduct,
        required String unitqty,
        required String unitqtyname,
        required String categoryName,
        required String gst,
        required String isDiscounted,
        required String discountedPrice}) async {
    print('add product${quantity}');
    cartDataList.add(CartData(
        id: id,
        orderId: orderId,
        productId: productId,
        unitPrice: unitPrice,
        quantity: quantity,
        price: price,
        image: imageProduct,
        name: nameProduct,
        unitqty: unitqty,
        unitqtyname: unitqtyname,
        categoryName: categoryName,
        gst: gst,
        isDiscounted: isDiscounted,
        discountedPrice: discountedPrice));
    productDataList.add(ProductArray(
        id: id.toString(),
        price: price.toString(),
        name: nameProduct,
        unitqty: unitqty,
        unitqtyname: unitqtyname,
        unitprice: unitPrice.toString(),
        qty: quantity.toString()));
    final String encodedData = CartData.encode(cartDataList);
    localRepository.setCartList(encodedData);
    final String encodedProductData = ProductArray.encode(productDataList);
    localRepository.setProductList(encodedProductData);
    update();
  }

  Future<void> counterAddProductToCart(CartData cartData) async {
    print('add product${cartData.quantity}');
    //
    //    int quantityUpdate = cartData.quantity! > 0?cartData.quantity!:0 + 1;
    // if(cartData.quantity! >= 1){
    int quantityUpdate = cartData.quantity! + 1;
    if (quantityUpdate >= 1) {
      CartData cartUpdate = CartData(
          id: cartData.id,
          orderId: cartData.orderId,
          productId: cartData.orderId,
          unitPrice: cartData.unitPrice,
          quantity: quantityUpdate,
          price: cartData.price,
          image: cartData.image,
          name: cartData.name,
          unitqty: cartData.unitqty,
          unitqtyname: cartData.unitqtyname,
          categoryName: cartData.categoryName,
          gst: cartData.gst,
          isDiscounted: cartData.isDiscounted,
          discountedPrice: cartData.discountedPrice);
      ProductArray productArrayUpdate = ProductArray(
          id: cartData.id.toString(),
          price: cartData.price.toString(),
          name: cartData.name,
          unitqtyname: cartData.unitqtyname,
          unitqty: cartData.unitqty,
          unitprice: cartData.unitPrice.toString(),
          qty: quantityUpdate.toString());
      cartDataList.indexOf(cartData);
      cartDataList[cartDataList
          .indexWhere((element) => element.id == cartData.id)] = cartUpdate;
      final String encodedData = CartData.encode(cartDataList);
      localRepository.setCartList(encodedData);

      productDataList.indexOf(cartData);
      productDataList[productDataList
          .indexWhere((element) => element.id == cartData.id.toString())] =
          productArrayUpdate;
      final String encodedProductData = ProductArray.encode(productDataList);
      localRepository.setProductList(encodedProductData);
      update();
    } else {
      addProductToCart(
        id: cartData.id!,
        orderId: cartData.orderId!,
        productId: cartData.orderId!,
        unitPrice: cartData.unitPrice!,
        quantity: quantityUpdate,
        price: cartData.price!,
        nameProduct: cartData.name!,
        imageProduct: cartData.image!,
        unitqty: cartData.unitqty!,
        unitqtyname: cartData.unitqtyname!,
        categoryName: cartData.categoryName!,
        gst: cartData.gst!,
        isDiscounted: cartData.isDiscounted!,
        discountedPrice: cartData.discountedPrice!,
      );
    }
    // }
  }

  Future<void> counterRemoveProductToCart(
      BuildContext context, CartData cartData) async {
    print('remove${cartData.quantity!}');
    if (cartData.quantity! > 1) {
      int quantityUpdate = cartData.quantity! + -1;
      print('remove $quantityUpdate');
      CartData cartUpdate = CartData(
          id: cartData.id,
          orderId: cartData.orderId,
          productId: cartData.orderId,
          unitPrice: cartData.unitPrice,
          quantity: quantityUpdate,
          price: cartData.price,
          image: cartData.image,
          name: cartData.name,
          unitqty: cartData.unitqty,
          unitqtyname: cartData.unitqtyname,
          categoryName: cartData.categoryName,
          gst: cartData.gst,
          isDiscounted: cartData.isDiscounted,
          discountedPrice: cartData.discountedPrice);
      ProductArray productUpdate = ProductArray(
          id: cartData.id.toString(),
          price: cartData.price.toString(),
          name: cartData.name,
          unitqtyname: cartData.unitqtyname,
          unitqty: cartData.unitqty,
          unitprice: cartData.unitPrice.toString(),
          qty:quantityUpdate.toString());
      cartDataList.indexOf(cartData);
      cartDataList[cartDataList
          .indexWhere((element) => element.id == cartData.id)] = cartUpdate;

      final String encodedData = CartData.encode(cartDataList);
      localRepository.setCartList(encodedData);

      productDataList.indexOf(cartData);
      productDataList[productDataList.indexWhere(
              (element) => element.id == cartData.id.toString())] = productUpdate;

      final String encodedProductData = ProductArray.encode(productDataList);
      localRepository.setProductList(encodedProductData);
      update();
    } else {
      _onTapRemoveLastItem(context, cartData);
      // deleteFromCart(idOrder: cartData.orderId!);
    }
  }

  _onTapRemoveLastItem(BuildContext context, CartData cartData) {
    AlertExtension(context).showSuccessAlert(
        title: 'Warning',
        message: 'Are you sure, you want to remove this item from cart?',
        cancelTextButton: 'NO',
        confirmTextButton: 'YES',
        onConfirm: () {
          deleteFromCart(idOrder: cartData.id!);
        },
        height: 170,
        width: MediaQuery.of(context).size.width - 40);
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in cartDataList) {
      num price = item.unitPrice!;
      total += item.quantity! * price;
    }
    print('total cart controller $total');
    return total;
  }

  double gstPrice() {
    double gst = 0;
    for (var item in cartDataList) {
      int price = int.parse(
          item.gst != null ? (item.gst!.isNotEmpty ? item.gst! : '0') : '0');
      gst += item.quantity! * price;
    }
    print('gst cart controller $gst');
    return gst;
  }

  double grandTotalPrice(double totalPrice, double gstPrice) {
    print('grand total controller ${totalPrice + gstPrice}');
    return totalPrice + gstPrice;
  }

  void deleteFromCart({required int idOrder}) async {
    cartDataList
        .removeAt(cartDataList.indexWhere((element) => element.id == idOrder));
    final String encodedData = CartData.encode(cartDataList);
    localRepository.setCartList(encodedData);

    productDataList.removeAt(productDataList
        .indexWhere((element) => element.id == idOrder.toString()));
    final String encodedProductData = ProductArray.encode(productDataList);
    localRepository.setProductList(encodedProductData);
    print('Done');
    update();
  }
}
