class ReceiptModel {
  String? name;
  int? qty;
  int? unitprice;
  int? gst;
  int? price;


  ReceiptModel(String name,
  int qty,
  int unitprice,
  int gst,
  int price){
    this.name = name;
    this.qty = qty;
    this.unitprice = unitprice;
    this.gst = gst;
    this.price=price;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "qty": qty,
      "unitprice": unitprice,
      "gst": gst,
      "price": price,
    };
  }
}