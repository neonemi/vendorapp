import 'dart:convert';

class Cart {
  String? message;
  CartData? data;
  int? status;

  Cart({this.message, this.data, this.status});

  Cart.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class CartData {
  int? orderId;
  int? productId;
  int? unitPrice;
  int? quantity;
  int? price;
  int? id;
  String? name;
  String? image;
  String? unitqty;
  String? unitqtyname;
  String? categoryName;
  String? gst;
  String? isDiscounted;
  String? discountedPrice;
  CartData({
    this.orderId,
    this.productId,
    this.unitPrice,
    this.quantity,
    this.price,
    this.id,
    this.image,
    this.name,
    this.categoryName,
    this.unitqty,
    this.unitqtyname,
    this.gst,
    this.discountedPrice,
    this.isDiscounted,
  });

  CartData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
    unitPrice = json['unitPrice'];
    quantity = json['quantity'];
    price = json['price'];
    unitqty = json['unitqty'];
    unitqtyname = json['unitqtyname'];
    categoryName = json['categoryName'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    gst = json['gst'];
    discountedPrice = json['discounted_price'];
    isDiscounted = json['is_discounted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['unitPrice'] = unitPrice;
    data['quantity'] = quantity;
    data['price'] = price;
    data['unitqty'] = unitqty;
    data['unitqtyname'] = unitqtyname;
    data['categoryName'] = categoryName;
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['gst'] = gst;
    data['is_discounted'] = isDiscounted;
    data['discounted_price'] = discountedPrice;
    return data;
  }

  static Map<String, dynamic> toMap(CartData cart) => {
    'order_id': cart.orderId,
    'product_id': cart.productId,
    'unitPrice': cart.unitPrice,
    'quantity': cart.quantity,
    'price': cart.price,
    'unitqty': cart.unitqty,
    'categoryName': cart.categoryName,
    'unitqtyname': cart.unitqtyname,
    'id': cart.id,
    'name': cart.name,
    'image': cart.image,
    'gst': cart.gst,
    'discounted_price': cart.discountedPrice,
    'is_discounted': cart.isDiscounted,
  };
  static String encode(List<CartData> cart) => json.encode(
    cart.map<Map<String, dynamic>>((cart) => CartData.toMap(cart)).toList(),
  );

  static List<CartData> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<CartData>((item) => CartData.fromJson(item))
          .toList();
}
