import 'dart:convert';
/// status : 200
/// message : "You Are Not Registred Please Register!"

OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));
String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());
class OtpResponse {
  OtpResponse({
      int? status, 
      String? message,
    String? data}){
    _status = status;
    _message = message;
    _data = data;
}

  OtpResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }
  int? _status;
  String? _message;
  String? _data;
  int? get status => _status;
  String? get message => _message;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }

}