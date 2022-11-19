import 'dart:convert';
/// status : 200
/// message : "User Updated Successfully"
/// data : {"id":256,"mobile":"7229975333","name":"Neo realme","email":"neologicxdeveloper@gmail.com","address":null,"created_at":"2022-10-03T08:57:07.000000Z","updated_at":"2022-11-18T06:14:54.000000Z","token":"cHlCYOVdXg8:APA91bEukzNUGj-opFq6VHvwMMEV1xpRF6Zc1JjGu4upPbVwmBtHnOzXxG2GHnuq7qVogdkDYGhK1_2s62n6LutXJfTc7aIKp-vxj956M9YMo-hDdprkUz7KBK0LN3Qyw6qJ8j_epWR7","image":"/storage/appuser/POXPknin6t8aLRZNMtrXhFegosOATbaaL8bEUPGz.jpg","is_ios":0,"dob":"1998-08-15 00:00:00","anniversary":null}

UpdateProfileResponse updateProfileResponseFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));
String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());
class UpdateProfileResponse {
  UpdateProfileResponse({
      int? status, 
      String? message, 
      UpdateProfileData? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  UpdateProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? UpdateProfileData.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  UpdateProfileData? _data;

  int? get status => _status;
  String? get message => _message;
  UpdateProfileData? get data => _data;

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

/// id : 256
/// mobile : "7229975333"
/// name : "Neo realme"
/// email : "neologicxdeveloper@gmail.com"
/// address : null
/// created_at : "2022-10-03T08:57:07.000000Z"
/// updated_at : "2022-11-18T06:14:54.000000Z"
/// token : "cHlCYOVdXg8:APA91bEukzNUGj-opFq6VHvwMMEV1xpRF6Zc1JjGu4upPbVwmBtHnOzXxG2GHnuq7qVogdkDYGhK1_2s62n6LutXJfTc7aIKp-vxj956M9YMo-hDdprkUz7KBK0LN3Qyw6qJ8j_epWR7"
/// image : "/storage/appuser/POXPknin6t8aLRZNMtrXhFegosOATbaaL8bEUPGz.jpg"
/// is_ios : 0
/// dob : "1998-08-15 00:00:00"
/// anniversary : null

UpdateProfileData updateProfileDataFromJson(String str) => UpdateProfileData.fromJson(json.decode(str));
String updateProfileDataToJson(UpdateProfileData data) => json.encode(data.toJson());
class UpdateProfileData {
  UpdateProfileData({
      int? id, 
      String? mobile, 
      String? name, 
      String? email, 
      String? address,
      String? createdAt, 
      String? updatedAt, 
      String? token, 
      String? image, 
      int? isIos, 
      String? dob, 
      String? anniversary,}){
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

  UpdateProfileData.fromJson(dynamic json) {
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
  String? _address;
  String? _createdAt;
  String? _updatedAt;
  String? _token;
  String? _image;
  int? _isIos;
  String? _dob;
  String? _anniversary;

  int? get id => _id;
  String? get mobile => _mobile;
  String? get name => _name;
  String? get email => _email;
  String? get address => _address;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get token => _token;
  String? get image => _image;
  int? get isIos => _isIos;
  String? get dob => _dob;
  String? get anniversary => _anniversary;

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