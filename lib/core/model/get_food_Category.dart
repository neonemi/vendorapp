import 'dart:convert';
/// status : 200
/// data : [{"id":1,"image":"/storage/categoryimage/WAkXPhZ0smzhVYH7ZJ6CV8ZMgg2G36NVImdCVZmm.jpg","name":"Sweets","is_active":1,"created_at":"2021-09-11T19:38:20.000000Z","updated_at":"2022-09-16T12:21:18.000000Z","parent_id":0,"gst":5},{"id":3,"image":"/storage/categoryimage/ohZ5ruS60AIyWVNRiOmOHcqERFgA3Ojim7f6Xcfg.jpg","name":"Snacks","is_active":1,"created_at":"2021-09-11T20:09:43.000000Z","updated_at":"2022-09-16T12:27:29.000000Z","parent_id":0,"gst":5},{"id":5,"image":"/storage/categoryimage/Pntv5wqIjsB94HCMUj00wgA9uZg0CLKC52Pku5Tj.jpg","name":"Milk Products","is_active":1,"created_at":"2021-09-11T21:05:24.000000Z","updated_at":"2022-09-16T12:38:16.000000Z","parent_id":0,"gst":5},{"id":7,"image":"/storage/categoryimage/73qkpoZEdV2qiLSnKLBeVtMgKJOALiMZ4MrGxdoZ.jpg","name":"BARFI","is_active":1,"created_at":"2022-09-16T12:09:37.000000Z","updated_at":"2022-09-16T12:09:37.000000Z","parent_id":0,"gst":5},{"id":9,"image":"/storage/categoryimage/53JHEo7TpCRNibjL3kQ6oEovWRY1Ky2kKc84wZhT.jpg","name":"LADOO","is_active":1,"created_at":"2022-09-16T12:11:47.000000Z","updated_at":"2022-09-16T12:11:47.000000Z","parent_id":0,"gst":5},{"id":10,"image":"/storage/categoryimage/1eT1TLcEhcdSY0Uw0aarAloYVteWEEnNI9FApWX9.jpg","name":"SAMOSA","is_active":1,"created_at":"2022-09-16T12:12:39.000000Z","updated_at":"2022-09-16T12:12:39.000000Z","parent_id":0,"gst":5},{"id":11,"image":"/storage/categoryimage/z4xz8Xc4iuY6UbMZDcTVSiAPEUqrVPYe7zq8mnpw.jpg","name":"DESI GHEE SWEETS","is_active":1,"created_at":"2022-09-16T12:39:22.000000Z","updated_at":"2022-09-16T12:39:22.000000Z","parent_id":0,"gst":5},{"id":12,"image":"/storage/categoryimage/ppdGFPtbgABETfO6XPQhvlri0jdWT4vX6GuXMMKB.jpg","name":"NAMKEEN","is_active":1,"created_at":"2022-09-16T12:45:57.000000Z","updated_at":"2022-09-16T12:45:57.000000Z","parent_id":0,"gst":5},{"id":14,"image":"/storage/categoryimage/wwsotAtCANs3HZgQ1t6NVJ1tBIeHEXCWEPLqibbb.jpg","name":"DESI GHEE SWEETS","is_active":1,"created_at":"2022-09-29T14:42:45.000000Z","updated_at":"2022-09-29T14:42:45.000000Z","parent_id":0,"gst":0}]

GetFoodCategory getFoodCategoryFromJson(String str) => GetFoodCategory.fromJson(json.decode(str));
String getFoodCategoryToJson(GetFoodCategory data) => json.encode(data.toJson());
class GetFoodCategory {
  GetFoodCategory({
      int? status, 
      List<CategoryData>? data,}){
    _status = status;
    _data = data;
}

  GetFoodCategory.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryData.fromJson(v));
      });
    }
  }
  int? _status;
  List<CategoryData>? _data;

  int? get status => _status;
  List<CategoryData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// image : "/storage/categoryimage/WAkXPhZ0smzhVYH7ZJ6CV8ZMgg2G36NVImdCVZmm.jpg"
/// name : "Sweets"
/// is_active : 1
/// created_at : "2021-09-11T19:38:20.000000Z"
/// updated_at : "2022-09-16T12:21:18.000000Z"
/// parent_id : 0
/// gst : 5

CategoryData categoryDataFromJson(String str) => CategoryData.fromJson(json.decode(str));
String categoryDataToJson(CategoryData data) => json.encode(data.toJson());
class CategoryData {
  CategoryData({
      int? id, 
      String? image, 
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

  CategoryData.fromJson(dynamic json) {
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
  String? _image;
  String? _name;
  int? _isActive;
  String? _createdAt;
  String? _updatedAt;
  int? _parentId;
  int? _gst;

  int? get id => _id;
  String? get image => _image;
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