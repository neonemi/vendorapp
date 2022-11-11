import 'dart:convert';
/// status : 200
/// message : "User Registered Successfully"
/// data : {"mobile":"1234567890","name":"vendor","email":"vendortest@mailsac.com","is_ios":"0","image":"","updated_at":"2022-11-11T11:35:14.000000Z","created_at":"2022-11-11T11:35:14.000000Z","id":260}

RegisterUserResponse registerUserResponseFromJson(String str) => RegisterUserResponse.fromJson(json.decode(str));
String registerUserResponseToJson(RegisterUserResponse data) => json.encode(data.toJson());
class RegisterUserResponse {
  RegisterUserResponse({
      int? status, 
      String? message, 
      RegisterData? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  RegisterUserResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  RegisterData? _data;

  int? get status => _status;
  String? get message => _message;
  RegisterData? get data => _data;

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

/// mobile : "1234567890"
/// name : "vendor"
/// email : "vendortest@mailsac.com"
/// is_ios : "0"
/// image : ""
/// updated_at : "2022-11-11T11:35:14.000000Z"
/// created_at : "2022-11-11T11:35:14.000000Z"
/// id : 260

RegisterData dataFromJson(String str) => RegisterData.fromJson(json.decode(str));
String dataToJson(RegisterData data) => json.encode(data.toJson());
class RegisterData {
  RegisterData({
      String? mobile, 
      String? name, 
      String? email, 
      String? isIos, 
      String? image, 
      String? updatedAt, 
      String? createdAt, 
      int? id,}){
    _mobile = mobile;
    _name = name;
    _email = email;
    _isIos = isIos;
    _image = image;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  RegisterData.fromJson(dynamic json) {
    _mobile = json['mobile'];
    _name = json['name'];
    _email = json['email'];
    _isIos = json['is_ios'];
    _image = json['image'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _mobile;
  String? _name;
  String? _email;
  String? _isIos;
  String? _image;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get mobile => _mobile;
  String? get name => _name;
  String? get email => _email;
  String? get isIos => _isIos;
  String? get image => _image;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = _mobile;
    map['name'] = _name;
    map['email'] = _email;
    map['is_ios'] = _isIos;
    map['image'] = _image;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}