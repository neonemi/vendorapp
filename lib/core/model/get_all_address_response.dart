import 'dart:convert';
/// status : 200
/// data : [{"id":29,"userid":220,"address":"Gaurav Plastic","is_default":1,"created_at":"2021-10-28T06:42:54.000000Z","updated_at":"2021-10-28T06:42:54.000000Z","location":"105, Sulaki Chauraha, Shiv Charan Lal Road, Bahadur Ganj, Zero Road, Prayagraj, Uttar Pradesh, India, 211003","floor":null,"lat":"25.4366037","lng":"81.84108189999999","landmark":"Beside Sulaki Juice Centre","pincode":211002}]

GetAllAddressResponse getAllAddressResponseFromJson(String str) => GetAllAddressResponse.fromJson(json.decode(str));
String getAllAddressResponseToJson(GetAllAddressResponse data) => json.encode(data.toJson());
class GetAllAddressResponse {
  GetAllAddressResponse({
      int? status, 
      List<AllAddressData>? data,}){
    _status = status;
    _data = data;
}

  GetAllAddressResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AllAddressData.fromJson(v));
      });
    }
  }
  int? _status;
  List<AllAddressData>? _data;

  int? get status => _status;
  List<AllAddressData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 29
/// userid : 220
/// address : "Gaurav Plastic"
/// is_default : 1
/// created_at : "2021-10-28T06:42:54.000000Z"
/// updated_at : "2021-10-28T06:42:54.000000Z"
/// location : "105, Sulaki Chauraha, Shiv Charan Lal Road, Bahadur Ganj, Zero Road, Prayagraj, Uttar Pradesh, India, 211003"
/// floor : null
/// lat : "25.4366037"
/// lng : "81.84108189999999"
/// landmark : "Beside Sulaki Juice Centre"
/// pincode : 211002

AllAddressData allAddressDataFromJson(String str) => AllAddressData.fromJson(json.decode(str));
String allAddressDataToJson(AllAddressData data) => json.encode(data.toJson());
class AllAddressData {
  AllAddressData({
      int? id, 
      int? userid, 
      String? address, 
      int? isDefault, 
      String? createdAt, 
      String? updatedAt, 
      String? location, 
      dynamic floor, 
      String? lat, 
      String? lng, 
      String? landmark, 
      int? pincode,}){
    _id = id;
    _userid = userid;
    _address = address;
    _isDefault = isDefault;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _location = location;
    _floor = floor;
    _lat = lat;
    _lng = lng;
    _landmark = landmark;
    _pincode = pincode;
}

  AllAddressData.fromJson(dynamic json) {
    _id = json['id'];
    _userid = json['userid'];
    _address = json['address'];
    _isDefault = json['is_default'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _location = json['location'];
    _floor = json['floor'];
    _lat = json['lat'];
    _lng = json['lng'];
    _landmark = json['landmark'];
    _pincode = json['pincode'];
  }
  int? _id;
  int? _userid;
  String? _address;
  int? _isDefault;
  String? _createdAt;
  String? _updatedAt;
  String? _location;
  dynamic _floor;
  String? _lat;
  String? _lng;
  String? _landmark;
  int? _pincode;

  int? get id => _id;
  int? get userid => _userid;
  String? get address => _address;
  int? get isDefault => _isDefault;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get location => _location;
  dynamic get floor => _floor;
  String? get lat => _lat;
  String? get lng => _lng;
  String? get landmark => _landmark;
  int? get pincode => _pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userid'] = _userid;
    map['address'] = _address;
    map['is_default'] = _isDefault;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['location'] = _location;
    map['floor'] = _floor;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['landmark'] = _landmark;
    map['pincode'] = _pincode;
    return map;
  }

}