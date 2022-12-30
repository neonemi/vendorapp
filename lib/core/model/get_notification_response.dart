import 'dart:convert';
/// status : 200
/// data : []

GetNotificationResponse getNotificationResponseFromJson(String str) => GetNotificationResponse.fromJson(json.decode(str));
String getNotificationResponseToJson(GetNotificationResponse data) => json.encode(data.toJson());
class GetNotificationResponse {
  GetNotificationResponse({
      int? status, 
      List<dynamic>? data,}){
    _status = status;
    _data = data;
}

  GetNotificationResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['_data'];
    // if (json['data'] != null) {
    //   _data = [];
    //   json['_data'].forEach((v) {
    //     _data?.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  int? _status;
  List<dynamic>? _data;

  int? get status => _status;
  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}