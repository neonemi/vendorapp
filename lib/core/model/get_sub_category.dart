import 'dart:convert';
/// status : 200
/// data : [{"id":18,"image":null,"name":"Open Vegetables","is_active":1,"created_at":"2022-12-21T06:12:18.000000Z","updated_at":"2022-12-21T06:12:18.000000Z","parent_id":12,"gst":0}]

GetSubCategory getSubCategoryFromJson(String str) => GetSubCategory.fromJson(json.decode(str));
String getSubCategoryToJson(GetSubCategory data) => json.encode(data.toJson());
class GetSubCategory {
  GetSubCategory({
      int? status, 
      List<SubCategoryData>? data,}){
    _status = status;
    _data = data;
}

  GetSubCategory.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SubCategoryData.fromJson(v));
      });
    }
  }
  int? _status;
  List<SubCategoryData>? _data;

  int? get status => _status;
  List<SubCategoryData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 18
/// image : null
/// name : "Open Vegetables"
/// is_active : 1
/// created_at : "2022-12-21T06:12:18.000000Z"
/// updated_at : "2022-12-21T06:12:18.000000Z"
/// parent_id : 12
/// gst : 0

SubCategoryData subCategoryDataFromJson(String str) => SubCategoryData.fromJson(json.decode(str));
String subCategoryDataToJson(SubCategoryData data) => json.encode(data.toJson());
class SubCategoryData {
  SubCategoryData({
      int? id, 
      dynamic image, 
      String? name, 
      int? isActive, 
      String? createdAt, 
      String? updatedAt, 
      int? parentId, 
      int? gst,}){
    _id = id;
    _image = image;
    _name = name;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _parentId = parentId;
    _gst = gst;
}

  SubCategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _name = json['name'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _parentId = json['parent_id'];
    _gst = json['gst'];
  }
  int? _id;
  dynamic _image;
  String? _name;
  int? _isActive;
  String? _createdAt;
  String? _updatedAt;
  int? _parentId;
  int? _gst;

  int? get id => _id;
  dynamic get image => _image;
  String? get name => _name;
  int? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get parentId => _parentId;
  int? get gst => _gst;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['name'] = _name;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['parent_id'] = _parentId;
    map['gst'] = _gst;
    return map;
  }

}