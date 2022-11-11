import 'dart:convert';
/// status : 200
/// message : "OTP Sent Successfully"
/// data : {"id":259,"mobile":"7229975333","name":"Neo Realme","email":"neologicxdeveloper@gmail.com","address":null,"created_at":"2022-11-02T05:16:23.000000Z","updated_at":"2022-11-02T05:16:23.000000Z","token":"195|qDZtJpxZFMRCemjNQgLsrc4Ci0ebKbLsUD0fwCPp","image":"/storage/","is_ios":0,"dob":null,"anniversary":null}

OtpVerifyResponse otpVerifyResponseFromJson(String str) => OtpVerifyResponse.fromJson(json.decode(str));
String otpVerifyResponseToJson(OtpVerifyResponse data) => json.encode(data.toJson());
class OtpVerifyResponse {
  OtpVerifyResponse({
      int? status, 
      String? message, 
      OtpData? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  OtpVerifyResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? OtpData.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  OtpData? _data;

  int? get status => _status;
  String? get message => _message;
  OtpData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 259
/// mobile : "7229975333"
/// name : "Neo Realme"
/// email : "neologicxdeveloper@gmail.com"
/// address : null
/// created_at : "2022-11-02T05:16:23.000000Z"
/// updated_at : "2022-11-02T05:16:23.000000Z"
/// token : "195|qDZtJpxZFMRCemjNQgLsrc4Ci0ebKbLsUD0fwCPp"
/// image : "/storage/"
/// is_ios : 0
/// dob : null
/// anniversary : null

OtpData otpdataFromJson(String str) => OtpData.fromJson(json.decode(str));
String otpdataToJson(OtpData data) => json.encode(data.toJson());
class OtpData {
  OtpData({
      int? id, 
      String? mobile, 
      String? name, 
      String? email, 
      dynamic address, 
      String? createdAt, 
      String? updatedAt, 
      String? token, 
      String? image, 
      int? isIos, 
      dynamic dob, 
      dynamic anniversary,}){
    _id = id;
    _mobile = mobile;
    _name = name;
    _email = email;
    _address = address;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _token = token;
    _image = image;
    _isIos = isIos;
    _dob = dob;
    _anniversary = anniversary;
}

  OtpData.fromJson(dynamic json) {
    _id = json['id'];
    _mobile = json['mobile'];
    _name = json['name'];
    _email = json['email'];
    _address = json['address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _token = json['token'];
    _image = json['image'];
    _isIos = json['is_ios'];
    _dob = json['dob'];
    _anniversary = json['anniversary'];
  }
  int? _id;
  String? _mobile;
  String? _name;
  String? _email;
  dynamic _address;
  String? _createdAt;
  String? _updatedAt;
  String? _token;
  String? _image;
  int? _isIos;
  dynamic _dob;
  dynamic _anniversary;

  int? get id => _id;
  String? get mobile => _mobile;
  String? get name => _name;
  String? get email => _email;
  dynamic get address => _address;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get token => _token;
  String? get image => _image;
  int? get isIos => _isIos;
  dynamic get dob => _dob;
  dynamic get anniversary => _anniversary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mobile'] = _mobile;
    map['name'] = _name;
    map['email'] = _email;
    map['address'] = _address;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['token'] = _token;
    map['image'] = _image;
    map['is_ios'] = _isIos;
    map['dob'] = _dob;
    map['anniversary'] = _anniversary;
    return map;
  }

}