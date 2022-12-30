import 'dart:convert';
/// status : 200
/// message : "Notification UnRead"
/// data : 3

GetUnReadNotificationCount getUnReadNotificationCountFromJson(String str) => GetUnReadNotificationCount.fromJson(json.decode(str));
String getUnReadNotificationCountToJson(GetUnReadNotificationCount data) => json.encode(data.toJson());
class GetUnReadNotificationCount {
  GetUnReadNotificationCount({
      int? status, 
      String? message, 
      int? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetUnReadNotificationCount.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }
  int? _status;
  String? _message;
  int? _data;

  int? get status => _status;
  String? get message => _message;
  int? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }

}