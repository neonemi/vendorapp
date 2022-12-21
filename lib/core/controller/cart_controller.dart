import 'package:get/get.dart';

import '../model/cart_data.dart';
import '../repository/local_repository.dart';

class CartController extends GetxController {
  CartController({required this.localRepository});
  var cartDataList = <CartData>[].obs;
  // late SharedPreferences storge;
  String cartListString = '';
  final LocalRepository localRepository;
  @override
  void onInit() async {
    cartListString = localRepository.getCartList() ?? '';
    if (cartListString != '') {
      final List<CartData> cartList = CartData.decode(cartListString);

      cartDataList.value = cartList;
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

    final String encodedData = CartData.encode(cartDataList);
    localRepository.setCartList(encodedData);
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
      );
      cartDataList.indexOf(cartData);
      cartDataList[cartDataList
          .indexWhere((element) => element.id == cartData.id)] = cartUpdate;
      final String encodedData = CartData.encode(cartDataList);
      localRepository.setCartList(encodedData);
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

  Future<void> counterRemoveProductToCart(CartData cartData) async {
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
      );
      cartDataList.indexOf(cartData);
      cartDataList[cartDataList
          .indexWhere((element) => element.id == cartData.id)] = cartUpdate;

      final String encodedData = CartData.encode(cartDataList);
      localRepository.setCartList(encodedData);
      update();
    } else {
      deleteFromCart(idOrder: cartData.orderId!);
    }
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in cartDataList) {
      num price = item.unitPrice!;
      total += item.quantity! * price;
    }
    return total;
  }

  void deleteFromCart({required int idOrder}) async {
    cartDataList
        .removeAt(cartDataList.indexWhere((element) => element.id == idOrder));
    final String encodedData = CartData.encode(cartDataList);
    localRepository.setCartList(encodedData);
    print('Done');
    update();
  }
}
