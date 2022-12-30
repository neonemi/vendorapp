import 'dart:convert';

class ProductArray {
  String? id;
  String? name;
  String? qty;
  String? unitqty;
  String? unitqtyname;
  String? unitprice;
  String? price;
  ProductArray({
    this.price,
    this.id,
    this.name,
    this.unitqty,
    this.unitqtyname,
    this.qty,
    this.unitprice
  });

  ProductArray.fromJson(Map<String, dynamic> json) {

    price = json['price'];
    unitqty = json['unitqty'];
    unitqtyname = json['unitqtyname'];
    id = json['id'];
    name = json['name'];
    qty = json['qty'];
    unitprice = json['unitprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['unitqty'] = unitqty;
    data['unitqtyname'] = unitqtyname;
    data['id'] = id;
    data['name'] = name;
    data['qty'] = qty;
    data['unitprice'] = unitprice;
    return data;
  }

  static Map<String, dynamic> toMap(ProductArray cart) => {
    'price': cart.price,
    'unitqty': cart.unitqty,
    'unitqtyname': cart.unitqtyname,
    'id': cart.id,
    'name': cart.name,
    'qty':cart.qty,
    'unitprice':cart.unitprice
  };
  static String encode(List<ProductArray> cart) => json.encode(
    cart.map<Map<String, dynamic>>((cart) => ProductArray.toMap(cart)).toList(),
  );

  static List<ProductArray> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<ProductArray>((item) => ProductArray.fromJson(item))
          .toList();
}
