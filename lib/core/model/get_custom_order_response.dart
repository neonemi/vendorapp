import 'dart:convert';
/// status : 200
/// data : [{"id":523,"name":"Test","mobile":"7229975333","address":"26 daga building kem road","coupon":null,"cartamount":1,"finalamount":51,"status":0,"created_at":"2022-12-26T07:32:06.000000Z","updated_at":"2022-12-26T08:12:17.000000Z","products":"[{\"id\":1,\"name\":\"Gulab jamun\",\"qty\":1,\"unitqty\":1,\"unitqtyname\":\"Pieces\",\"unitprice\":1,\"price\":1}]","billing_charges":null,"coupon_amount":null,"deliveryinchargename":null,"deliveryinchargemobile":null,"deliveryinchargedetails":null,"notes":null,"rider_id":null,"order_status":"placed","deliver_at":null,"otp":"7264","delivery_message":null,"rating":null,"payment_status":"1","orderitems":[{"id":863,"orderid":523,"productid":1,"qty":1,"created_at":"2022-12-26T07:32:06.000000Z","updated_at":"2022-12-26T07:32:06.000000Z","is_unavailable":0,"reason":null,"unitprice":1,"price":1,"name":"Gulab jamun","unitqtyname":"Pieces","unitqty":1,"gst":0}]}]
/// message : "status changed successfully"

GetCustomerOrderResponse getCustomOrderFromJson(String str) => GetCustomerOrderResponse.fromJson(json.decode(str));
String getCustomOrderToJson(GetCustomerOrderResponse data) => json.encode(data.toJson());
class GetCustomerOrderResponse {
  GetCustomerOrderResponse({
    int? status,
    List<CustomerOrderData>? data,
    String? message,}){
    _status = status;
    _data = data;
    _message = message;
  }

  GetCustomerOrderResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CustomerOrderData.fromJson(v));
      });
    }
    _message = json['message'];
  }
  int? _status;
  List<CustomerOrderData>? _data;
  String? _message;

  int? get status => _status;
  List<CustomerOrderData>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// id : 523
/// name : "Test"
/// mobile : "7229975333"
/// address : "26 daga building kem road"
/// coupon : null
/// cartamount : 1
/// finalamount : 51
/// status : 0
/// created_at : "2022-12-26T07:32:06.000000Z"
/// updated_at : "2022-12-26T08:12:17.000000Z"
/// products : "[{\"id\":1,\"name\":\"Gulab jamun\",\"qty\":1,\"unitqty\":1,\"unitqtyname\":\"Pieces\",\"unitprice\":1,\"price\":1}]"
/// billing_charges : null
/// coupon_amount : null
/// deliveryinchargename : null
/// deliveryinchargemobile : null
/// deliveryinchargedetails : null
/// notes : null
/// rider_id : null
/// order_status : "placed"
/// deliver_at : null
/// otp : "7264"
/// delivery_message : null
/// rating : null
/// payment_status : "1"
/// orderitems : [{"id":863,"orderid":523,"productid":1,"qty":1,"created_at":"2022-12-26T07:32:06.000000Z","updated_at":"2022-12-26T07:32:06.000000Z","is_unavailable":0,"reason":null,"unitprice":1,"price":1,"name":"Gulab jamun","unitqtyname":"Pieces","unitqty":1,"gst":0}]

CustomerOrderData customerOrderDataFromJson(String str) => CustomerOrderData.fromJson(json.decode(str));
String customerOrderDataToJson(CustomerOrderData data) => json.encode(data.toJson());
class CustomerOrderData {
  CustomerOrderData({
    int? id,
    String? name,
    String? mobile,
    String? address,
    dynamic coupon,
    int? cartamount,
    int? finalamount,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? products,
    dynamic billingCharges,
    dynamic couponAmount,
    dynamic deliveryinchargename,
    dynamic deliveryinchargemobile,
    dynamic deliveryinchargedetails,
    dynamic notes,
    dynamic riderId,
    String? orderStatus,
    dynamic deliverAt,
    String? otp,
    dynamic deliveryMessage,
    dynamic rating,
    String? paymentStatus,
    List<Orderitems>? orderitems,}){
    _id = id;
    _name = name;
    _mobile = mobile;
    _address = address;
    _coupon = coupon;
    _cartamount = cartamount;
    _finalamount = finalamount;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _products = products;
    _billingCharges = billingCharges;
    _couponAmount = couponAmount;
    _deliveryinchargename = deliveryinchargename;
    _deliveryinchargemobile = deliveryinchargemobile;
    _deliveryinchargedetails = deliveryinchargedetails;
    _notes = notes;
    _riderId = riderId;
    _orderStatus = orderStatus;
    _deliverAt = deliverAt;
    _otp = otp;
    _deliveryMessage = deliveryMessage;
    _rating = rating;
    _paymentStatus = paymentStatus;
    _orderitems = orderitems;
  }

  CustomerOrderData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _address = json['address'];
    _coupon = json['coupon'];
    _cartamount = json['cartamount'];
    _finalamount = json['finalamount'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _products = json['products'];
    _billingCharges = json['billing_charges'];
    _couponAmount = json['coupon_amount'];
    _deliveryinchargename = json['deliveryinchargename'];
    _deliveryinchargemobile = json['deliveryinchargemobile'];
    _deliveryinchargedetails = json['deliveryinchargedetails'];
    _notes = json['notes'];
    _riderId = json['rider_id'];
    _orderStatus = json['order_status'];
    _deliverAt = json['deliver_at'];
    _otp = json['otp'];
    _deliveryMessage = json['delivery_message'];
    _rating = json['rating'];
    _paymentStatus = json['payment_status'];
    if (json['orderitems'] != null) {
      _orderitems = [];
      json['orderitems'].forEach((v) {
        _orderitems?.add(Orderitems.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _mobile;
  String? _address;
  dynamic _coupon;
  int? _cartamount;
  int? _finalamount;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _products;
  dynamic _billingCharges;
  dynamic _couponAmount;
  dynamic _deliveryinchargename;
  dynamic _deliveryinchargemobile;
  dynamic _deliveryinchargedetails;
  dynamic _notes;
  dynamic _riderId;
  String? _orderStatus;
  dynamic _deliverAt;
  String? _otp;
  dynamic _deliveryMessage;
  dynamic _rating;
  String? _paymentStatus;
  List<Orderitems>? _orderitems;

  int? get id => _id;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get address => _address;
  dynamic get coupon => _coupon;
  int? get cartamount => _cartamount;
  int? get finalamount => _finalamount;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get products => _products;
  dynamic get billingCharges => _billingCharges;
  dynamic get couponAmount => _couponAmount;
  dynamic get deliveryinchargename => _deliveryinchargename;
  dynamic get deliveryinchargemobile => _deliveryinchargemobile;
  dynamic get deliveryinchargedetails => _deliveryinchargedetails;
  dynamic get notes => _notes;
  dynamic get riderId => _riderId;
  String? get orderStatus => _orderStatus;
  dynamic get deliverAt => _deliverAt;
  String? get otp => _otp;
  dynamic get deliveryMessage => _deliveryMessage;
  dynamic get rating => _rating;
  String? get paymentStatus => _paymentStatus;
  List<Orderitems>? get orderitems => _orderitems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['coupon'] = _coupon;
    map['cartamount'] = _cartamount;
    map['finalamount'] = _finalamount;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['products'] = _products;
    map['billing_charges'] = _billingCharges;
    map['coupon_amount'] = _couponAmount;
    map['deliveryinchargename'] = _deliveryinchargename;
    map['deliveryinchargemobile'] = _deliveryinchargemobile;
    map['deliveryinchargedetails'] = _deliveryinchargedetails;
    map['notes'] = _notes;
    map['rider_id'] = _riderId;
    map['order_status'] = _orderStatus;
    map['deliver_at'] = _deliverAt;
    map['otp'] = _otp;
    map['delivery_message'] = _deliveryMessage;
    map['rating'] = _rating;
    map['payment_status'] = _paymentStatus;
    if (_orderitems != null) {
      map['orderitems'] = _orderitems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 863
/// orderid : 523
/// productid : 1
/// qty : 1
/// created_at : "2022-12-26T07:32:06.000000Z"
/// updated_at : "2022-12-26T07:32:06.000000Z"
/// is_unavailable : 0
/// reason : null
/// unitprice : 1
/// price : 1
/// name : "Gulab jamun"
/// unitqtyname : "Pieces"
/// unitqty : 1
/// gst : 0

Orderitems orderitemsFromJson(String str) => Orderitems.fromJson(json.decode(str));
String orderitemsToJson(Orderitems data) => json.encode(data.toJson());
class Orderitems {
  Orderitems({
    int? id,
    int? orderid,
    int? productid,
    int? qty,
    String? createdAt,
    String? updatedAt,
    int? isUnavailable,
    dynamic reason,
    int? unitprice,
    int? price,
    String? name,
    String? unitqtyname,
    int? unitqty,
    int? gst,}){
    _id = id;
    _orderid = orderid;
    _productid = productid;
    _qty = qty;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _isUnavailable = isUnavailable;
    _reason = reason;
    _unitprice = unitprice;
    _price = price;
    _name = name;
    _unitqtyname = unitqtyname;
    _unitqty = unitqty;
    _gst = gst;
  }

  Orderitems.fromJson(dynamic json) {
    _id = json['id'];
    _orderid = json['orderid'];
    _productid = json['productid'];
    _qty = json['qty'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _isUnavailable = json['is_unavailable'];
    _reason = json['reason'];
    _unitprice = json['unitprice'];
    _price = json['price'];
    _name = json['name'];
    _unitqtyname = json['unitqtyname'];
    _unitqty = json['unitqty'];
    _gst = json['gst'];
  }
  int? _id;
  int? _orderid;
  int? _productid;
  int? _qty;
  String? _createdAt;
  String? _updatedAt;
  int? _isUnavailable;
  dynamic _reason;
  int? _unitprice;
  int? _price;
  String? _name;
  String? _unitqtyname;
  int? _unitqty;
  int? _gst;

  int? get id => _id;
  int? get orderid => _orderid;
  int? get productid => _productid;
  int? get qty => _qty;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get isUnavailable => _isUnavailable;
  dynamic get reason => _reason;
  int? get unitprice => _unitprice;
  int? get price => _price;
  String? get name => _name;
  String? get unitqtyname => _unitqtyname;
  int? get unitqty => _unitqty;
  int? get gst => _gst;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['orderid'] = _orderid;
    map['productid'] = _productid;
    map['qty'] = _qty;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['is_unavailable'] = _isUnavailable;
    map['reason'] = _reason;
    map['unitprice'] = _unitprice;
    map['price'] = _price;
    map['name'] = _name;
    map['unitqtyname'] = _unitqtyname;
    map['unitqty'] = _unitqty;
    map['gst'] = _gst;
    return map;
  }

}