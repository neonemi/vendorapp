import 'dart:convert';
/// status : 200
/// data : {"shop_mobile":"1","order_status":"placed","rider_lat":"0","rider_lng":"0","rider_mobile":"","rider_name":""}
/// message : "Order status"

GetTrackOrderResponse getTrackOrderResponseFromJson(String str) => GetTrackOrderResponse.fromJson(json.decode(str));
String getTrackOrderResponseToJson(GetTrackOrderResponse data) => json.encode(data.toJson());
class GetTrackOrderResponse {
  GetTrackOrderResponse({
      int? status, 
      TrackData? data,
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetTrackOrderResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? TrackData.fromJson(json['data']) : null;
    _message = json['message'];
  }
  int? _status;
  TrackData? _data;
  String? _message;

  int? get status => _status;
  TrackData? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// shop_mobile : "1"
/// order_status : "placed"
/// rider_lat : "0"
/// rider_lng : "0"
/// rider_mobile : ""
/// rider_name : ""

TrackData trackDataFromJson(String str) => TrackData.fromJson(json.decode(str));
String trackDataToJson(TrackData data) => json.encode(data.toJson());
class TrackData {
  TrackData({
      String? shopMobile, 
      String? orderStatus, 
      String? riderLat, 
      String? riderLng, 
      String? riderMobile, 
      String? riderName,}){
    _shopMobile = shopMobile;
    _orderStatus = orderStatus;
    _riderLat = riderLat;
    _riderLng = riderLng;
    _riderMobile = riderMobile;
    _riderName = riderName;
}

  TrackData.fromJson(dynamic json) {
    _shopMobile = json['shop_mobile'];
    _orderStatus = json['order_status'];
    _riderLat = json['rider_lat'];
    _riderLng = json['rider_lng'];
    _riderMobile = json['rider_mobile'];
    _riderName = json['rider_name'];
  }
  String? _shopMobile;
  String? _orderStatus;
  String? _riderLat;
  String? _riderLng;
  String? _riderMobile;
  String? _riderName;

  String? get shopMobile => _shopMobile;
  String? get orderStatus => _orderStatus;
  String? get riderLat => _riderLat;
  String? get riderLng => _riderLng;
  String? get riderMobile => _riderMobile;
  String? get riderName => _riderName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['shop_mobile'] = _shopMobile;
    map['order_status'] = _orderStatus;
    map['rider_lat'] = _riderLat;
    map['rider_lng'] = _riderLng;
    map['rider_mobile'] = _riderMobile;
    map['rider_name'] = _riderName;
    return map;
  }

}