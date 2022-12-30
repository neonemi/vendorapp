import 'dart:convert';
/// status : 200
/// message : "Order Created Successfully"
/// order_id : 522
/// payment_status : "pending"

GetOrderResponse getOrderResponseFromJson(String str) => GetOrderResponse.fromJson(json.decode(str));
String getOrderResponseToJson(GetOrderResponse data) => json.encode(data.toJson());
class GetOrderResponse {
  GetOrderResponse({
      int? status, 
      String? message, 
      int? orderId, 
      String? paymentStatus,}){
    _status = status;
    _message = message;
    _orderId = orderId;
    _paymentStatus = paymentStatus;
}

  GetOrderResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _orderId = json['order_id'];
    _paymentStatus = json['payment_status'];
  }
  int? _status;
  String? _message;
  int? _orderId;
  String? _paymentStatus;

  int? get status => _status;
  String? get message => _message;
  int? get orderId => _orderId;
  String? get paymentStatus => _paymentStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['order_id'] = _orderId;
    map['payment_status'] = _paymentStatus;
    return map;
  }

}