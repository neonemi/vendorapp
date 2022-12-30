import 'dart:convert';
/// status : 200
/// order_id : "522"
/// message : "Transaction successfully done"

GetPaymentPayloadResponse getPaymentPayloadeResponseFromJson(String str) => GetPaymentPayloadResponse.fromJson(json.decode(str));
String getPaymentPayloadeResponseToJson(GetPaymentPayloadResponse data) => json.encode(data.toJson());
class GetPaymentPayloadResponse {
  GetPaymentPayloadResponse({
      int? status, 
      String? orderId, 
      String? message,}){
    _status = status;
    _orderId = orderId;
    _message = message;
}

  GetPaymentPayloadResponse.fromJson(dynamic json) {
    _status = json['status'];
    _orderId = json['order_id'];
    _message = json['message'];
  }
  int? _status;
  String? _orderId;
  String? _message;

  int? get status => _status;
  String? get orderId => _orderId;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['order_id'] = _orderId;
    map['message'] = _message;
    return map;
  }

}