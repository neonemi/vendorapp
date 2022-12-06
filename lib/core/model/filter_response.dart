import 'dart:convert';
/// status : 200
/// data : [{"id":14,"name":"Sweets Only","is_active":null,"created_at":"2021-09-15T18:37:27.000000Z","updated_at":"2021-09-15T18:37:27.000000Z"},{"id":12,"name":"Price","is_active":null,"created_at":"2021-09-15T17:57:24.000000Z","updated_at":"2021-09-15T18:11:10.000000Z"}]

FilterResponse filterResponseFromJson(String str) => FilterResponse.fromJson(json.decode(str));
String filterResponseToJson(FilterResponse data) => json.encode(data.toJson());
class FilterResponse {
  FilterResponse({
      int? status, 
      List<FilterData>? data,}){
    _status = status;
    _data = data;
}

  FilterResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FilterData.fromJson(v));
      });
    }
  }
  int? _status;
  List<FilterData>? _data;

  int? get status => _status;
  List<FilterData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 14
/// name : "Sweets Only"
/// is_active : null
/// created_at : "2021-09-15T18:37:27.000000Z"
/// updated_at : "2021-09-15T18:37:27.000000Z"

FilterData filterDataFromJson(String str) => FilterData.fromJson(json.decode(str));
String filterDataToJson(FilterData data) => json.encode(data.toJson());
class FilterData {
  FilterData({
      int? id, 
      String? name, 
      dynamic isActive, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  FilterData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  dynamic _isActive;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  dynamic get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}