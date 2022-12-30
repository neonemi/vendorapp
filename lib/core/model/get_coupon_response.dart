import 'dart:convert';
/// status : 200
/// message : ""
/// data : []

GetCouponResponse getCouponResponseFromJson(String str) => GetCouponResponse.fromJson(json.decode(str));
String getCouponResponseToJson(GetCouponResponse data) => json.encode(data.toJson());
class GetCouponResponse {
  GetCouponResponse({
      int? status, 
      String? message, 
      List<dynamic>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetCouponResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data=json['data'];
    // if (json['data'] != null) {
    //   _data = [];
    //   json['data'].forEach((v) {
    //     _data?.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  int? _status;
  String? _message;
  List<dynamic>? _data;

  int? get status => _status;
  String? get message => _message;
  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}