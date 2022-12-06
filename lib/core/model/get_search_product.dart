import 'dart:convert';
/// status : 200
/// data : [{"id":15,"name":"Desi Ghee mix sweets","image":"/storage/productimage/ktJqWPjjCv3HNmlv0sIanWtcyB6A4ffA3is4JdPQ.jpg","price":480,"type":"","category_id":2,"is_active":1,"created_at":"2021-09-11T21:03:00.000000Z","updated_at":"2022-09-13T16:16:33.000000Z","unitqty":1,"unitqtyname":"Kgs.","description":"Desi Ghee mix sweets","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":"","category":"Sweets","categoryrelation":{"id":2,"image":null,"name":"Sweets","is_active":1,"created_at":"2021-09-11T19:38:35.000000Z","updated_at":"2021-09-11T19:38:35.000000Z","parent_id":1,"gst":5}},{"id":16,"name":"khoya chana mix sweets","image":"/storage/productimage/nyMPU3yOpIk4y1aQ3gatmvnwnmcRwqiyGKpxBGw6.jpg","price":420,"type":"","category_id":2,"is_active":1,"created_at":"2021-09-11T21:03:55.000000Z","updated_at":"2022-09-13T15:44:43.000000Z","unitqty":1,"unitqtyname":"Kgs.","description":"khoya chana mix sweets","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":"","category":"Sweets","categoryrelation":{"id":2,"image":null,"name":"Sweets","is_active":1,"created_at":"2021-09-11T19:38:35.000000Z","updated_at":"2021-09-11T19:38:35.000000Z","parent_id":1,"gst":5}},{"id":47,"name":"TILL TOSA MATHRI SWEETS","image":"/storage/productimage/1nxwZzRi2TM0G74yzGOO89SyttT0SVXeUkrZelxb.jpg","price":75,"type":"","category_id":4,"is_active":1,"created_at":"2022-09-16T15:01:48.000000Z","updated_at":"2022-09-16T15:01:48.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"PLASTIC CANTENER PACK 250 GM","is_discounted":0,"discounted_price":null,"pin":211003,"qtyname":"","category":"Snacks","categoryrelation":{"id":4,"image":null,"name":"Snacks","is_active":1,"created_at":"2021-09-11T20:09:55.000000Z","updated_at":"2021-09-11T20:09:55.000000Z","parent_id":3,"gst":5}},{"id":48,"name":"TILL TOSA MATHRI SWEETS","image":"/storage/productimage/H8aHvj4zVedcJAz9gVOnDmCGTxfI86H3CwvSBMZS.jpg","price":75,"type":"","category_id":4,"is_active":1,"created_at":"2022-09-16T15:01:49.000000Z","updated_at":"2022-09-16T15:01:49.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"PLASTIC CANTENER PACK 250 GM","is_discounted":0,"discounted_price":null,"pin":211003,"qtyname":"","category":"Snacks","categoryrelation":{"id":4,"image":null,"name":"Snacks","is_active":1,"created_at":"2021-09-11T20:09:55.000000Z","updated_at":"2021-09-11T20:09:55.000000Z","parent_id":3,"gst":5}}]

GetSearchProduct getSearchProductFromJson(String str) => GetSearchProduct.fromJson(json.decode(str));
String getSearchProductToJson(GetSearchProduct data) => json.encode(data.toJson());
class GetSearchProduct {
  GetSearchProduct({
      int? status, 
      List<searchData>? data,}){
    _status = status;
    _data = data;
}

  GetSearchProduct.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(searchData.fromJson(v));
      });
    }
  }
  int? _status;
  List<searchData>? _data;

  int? get status => _status;
  List<searchData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 15
/// name : "Desi Ghee mix sweets"
/// image : "/storage/productimage/ktJqWPjjCv3HNmlv0sIanWtcyB6A4ffA3is4JdPQ.jpg"
/// price : 480
/// type : ""
/// category_id : 2
/// is_active : 1
/// created_at : "2021-09-11T21:03:00.000000Z"
/// updated_at : "2022-09-13T16:16:33.000000Z"
/// unitqty : 1
/// unitqtyname : "Kgs."
/// description : "Desi Ghee mix sweets"
/// is_discounted : 0
/// discounted_price : 0
/// pin : 211003
/// qtyname : ""
/// category : "Sweets"
/// categoryrelation : {"id":2,"image":null,"name":"Sweets","is_active":1,"created_at":"2021-09-11T19:38:35.000000Z","updated_at":"2021-09-11T19:38:35.000000Z","parent_id":1,"gst":5}

searchData searchDataFromJson(String str) => searchData.fromJson(json.decode(str));
String searchDataToJson(searchData data) => json.encode(data.toJson());
class searchData {
  searchData({
      int? id, 
      String? name, 
      String? image, 
      int? price, 
      String? type, 
      int? categoryId, 
      int? isActive, 
      String? createdAt, 
      String? updatedAt, 
      int? unitqty, 
      String? unitqtyname, 
      String? description, 
      int? isDiscounted, 
      int? discountedPrice, 
      int? pin, 
      String? qtyname, 
      String? category, 
      Categoryrelation? categoryrelation,}){
    _id = id;
    _name = name;
    _image = image;
    _price = price;
    _type = type;
    _categoryId = categoryId;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _unitqty = unitqty;
    _unitqtyname = unitqtyname;
    _description = description;
    _isDiscounted = isDiscounted;
    _discountedPrice = discountedPrice;
    _pin = pin;
    _qtyname = qtyname;
    _category = category;
    _categoryrelation = categoryrelation;
}

  searchData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _price = json['price'];
    _type = json['type'];
    _categoryId = json['category_id'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _unitqty = json['unitqty'];
    _unitqtyname = json['unitqtyname'];
    _description = json['description'];
    _isDiscounted = json['is_discounted'];
    _discountedPrice = json['discounted_price'];
    _pin = json['pin'];
    _qtyname = json['qtyname'];
    _category = json['category'];
    _categoryrelation = json['categoryrelation'] != null ? Categoryrelation.fromJson(json['categoryrelation']) : null;
  }
  int? _id;
  String? _name;
  String? _image;
  int? _price;
  String? _type;
  int? _categoryId;
  int? _isActive;
  String? _createdAt;
  String? _updatedAt;
  int? _unitqty;
  String? _unitqtyname;
  String? _description;
  int? _isDiscounted;
  int? _discountedPrice;
  int? _pin;
  String? _qtyname;
  String? _category;
  Categoryrelation? _categoryrelation;

  int? get id => _id;
  String? get name => _name;
  String? get image => _image;
  int? get price => _price;
  String? get type => _type;
  int? get categoryId => _categoryId;
  int? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get unitqty => _unitqty;
  String? get unitqtyname => _unitqtyname;
  String? get description => _description;
  int? get isDiscounted => _isDiscounted;
  int? get discountedPrice => _discountedPrice;
  int? get pin => _pin;
  String? get qtyname => _qtyname;
  String? get category => _category;
  Categoryrelation? get categoryrelation => _categoryrelation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['price'] = _price;
    map['type'] = _type;
    map['category_id'] = _categoryId;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['unitqty'] = _unitqty;
    map['unitqtyname'] = _unitqtyname;
    map['description'] = _description;
    map['is_discounted'] = _isDiscounted;
    map['discounted_price'] = _discountedPrice;
    map['pin'] = _pin;
    map['qtyname'] = _qtyname;
    map['category'] = _category;
    if (_categoryrelation != null) {
      map['categoryrelation'] = _categoryrelation?.toJson();
    }
    return map;
  }

}

/// id : 2
/// image : null
/// name : "Sweets"
/// is_active : 1
/// created_at : "2021-09-11T19:38:35.000000Z"
/// updated_at : "2021-09-11T19:38:35.000000Z"
/// parent_id : 1
/// gst : 5

Categoryrelation categoryrelationFromJson(String str) => Categoryrelation.fromJson(json.decode(str));
String categoryrelationToJson(Categoryrelation data) => json.encode(data.toJson());
class Categoryrelation {
  Categoryrelation({
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

  Categoryrelation.fromJson(dynamic json) {
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