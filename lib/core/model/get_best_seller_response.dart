import 'dart:convert';
/// status : 200
/// data : [{"id":1,"name":"Gulab jamun","image":"/storage/productimage/CtOfqJBrLpvPg6McS5dLhIXaX1xUdaovtGCWN9GK.jpg","price":18,"type":"","category_id":2,"is_active":1,"created_at":"2021-09-11T20:11:47.000000Z","updated_at":"2022-09-13T15:22:52.000000Z","unitqty":1,"unitqtyname":"Pieces","description":"Gulab jamun","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":2,"name":"White Rasgulla","image":"/storage/productimage/zTgp5VhdRVhupmMMRt2f47vJIPLqOVAl8oZAPkm7.jpg","price":14,"type":"","category_id":2,"is_active":1,"created_at":"2021-09-11T20:13:08.000000Z","updated_at":"2022-09-13T15:59:25.000000Z","unitqty":1,"unitqtyname":"Pieces","description":"White Rasgulla","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":4,"name":"Rasmalai","image":"/storage/productimage/7vYyLkf5xOtdgzdgCtkdySOlpfqNeB4Qboogjq9F.jpg","price":25,"type":"","category_id":2,"is_active":1,"created_at":"2021-09-11T20:15:19.000000Z","updated_at":"2022-09-13T15:16:42.000000Z","unitqty":1,"unitqtyname":"Pieces","description":"Rasmalai","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":12,"name":"Besan Ladoo","image":"/storage/productimage/XSvBWDgliNT0M684K0Id1kqmvKsEvnIOn0n6qyif.jpg","price":60,"type":"Price","category_id":2,"is_active":1,"created_at":"2021-09-11T21:00:01.000000Z","updated_at":"2022-09-29T15:39:29.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"Besan Ladoo","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":15,"name":"Desi Ghee mix sweets","image":"/storage/productimage/ktJqWPjjCv3HNmlv0sIanWtcyB6A4ffA3is4JdPQ.jpg","price":480,"type":"","category_id":2,"is_active":1,"created_at":"2021-09-11T21:03:00.000000Z","updated_at":"2022-09-13T16:16:33.000000Z","unitqty":1,"unitqtyname":"Kgs.","description":"Desi Ghee mix sweets","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":36,"name":"AATA MEWA LADOO","image":"/storage/productimage/qjcaJbAMKsY1PuZf8FMVZjOCFNtPRCCrA0H0QaiP.jpg","price":140,"type":"Sweets Only","category_id":2,"is_active":1,"created_at":"2022-09-16T13:39:31.000000Z","updated_at":"2022-09-29T14:51:46.000000Z","unitqty":250,"unitqtyname":"Gms.","description":null,"is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":46,"name":"SUGER KHURMA","image":"/storage/productimage/dgnDZMRiq6PvHgwFwjnvBMukJ0wAZOSDnCqdnStL.jpg","price":60,"type":"Price","category_id":2,"is_active":1,"created_at":"2022-09-16T14:57:13.000000Z","updated_at":"2022-09-16T14:57:13.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"PLASTIC CANTENER PACK 250 GM","is_discounted":0,"discounted_price":null,"pin":211003,"qtyname":""}]

GetBestSellerResponse getBestSellerResponseFromJson(String str) => GetBestSellerResponse.fromJson(json.decode(str));
String getBestSellerResponseToJson(GetBestSellerResponse data) => json.encode(data.toJson());
class GetBestSellerResponse {
  GetBestSellerResponse({
      int? status, 
      List<BestSellerData>? data,}){
    _status = status;
    _data = data;
}

  GetBestSellerResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BestSellerData.fromJson(v));
      });
    }
  }
  int? _status;
  List<BestSellerData>? _data;

  int? get status => _status;
  List<BestSellerData>? get data => _data;

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
/// name : "Gulab jamun"
/// image : "/storage/productimage/CtOfqJBrLpvPg6McS5dLhIXaX1xUdaovtGCWN9GK.jpg"
/// price : 18
/// type : ""
/// category_id : 2
/// is_active : 1
/// created_at : "2021-09-11T20:11:47.000000Z"
/// updated_at : "2022-09-13T15:22:52.000000Z"
/// unitqty : 1
/// unitqtyname : "Pieces"
/// description : "Gulab jamun"
/// is_discounted : 0
/// discounted_price : 0
/// pin : 211003
/// qtyname : ""

BestSellerData bestSellerDataFromJson(String str) => BestSellerData.fromJson(json.decode(str));
String bestSellerDataToJson(BestSellerData data) => json.encode(data.toJson());
class BestSellerData {
  BestSellerData({
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
      String? qtyname,}){
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
}

  BestSellerData.fromJson(dynamic json) {
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
    return map;
  }

}