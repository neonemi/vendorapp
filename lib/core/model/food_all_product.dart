import 'dart:convert';
/// status : 200
/// data : {"current_page":1,"data":[{"id":49,"name":"BLACK JAMUN","image":"/storage/productimage/2CWnWfvvbKbHD96HaaXGeSpCUAkE5HB65jp7cGx1.jpg","price":18,"type":"Sweets Only","category_id":2,"is_active":1,"created_at":"2022-09-16T15:07:08.000000Z","updated_at":"2022-09-30T10:05:34.000000Z","unitqty":1,"unitqtyname":"Pieces","description":"BLACK JAMUN , 18 PER PCS","is_discounted":0,"discounted_price":null,"pin":211003,"qtyname":""},{"id":46,"name":"SUGER KHURMA","image":"/storage/productimage/dgnDZMRiq6PvHgwFwjnvBMukJ0wAZOSDnCqdnStL.jpg","price":60,"type":"Price","category_id":2,"is_active":1,"created_at":"2022-09-16T14:57:13.000000Z","updated_at":"2022-09-16T14:57:13.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"PLASTIC CANTENER PACK 250 GM","is_discounted":0,"discounted_price":null,"pin":211003,"qtyname":""},{"id":37,"name":"DESI GHEE RAJASTHANI LADOO","image":"/storage/productimage/EWxKC2scEAL7n7Vnmc2TVXiXN2I5DJXV6U44nDt2.jpg","price":120,"type":"Price","category_id":2,"is_active":1,"created_at":"2022-09-16T13:47:18.000000Z","updated_at":"2022-09-29T14:49:56.000000Z","unitqty":250,"unitqtyname":"Gms.","description":null,"is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":36,"name":"AATA MEWA LADOO","image":"/storage/productimage/qjcaJbAMKsY1PuZf8FMVZjOCFNtPRCCrA0H0QaiP.jpg","price":140,"type":"Sweets Only","category_id":2,"is_active":1,"created_at":"2022-09-16T13:39:31.000000Z","updated_at":"2022-09-29T14:51:46.000000Z","unitqty":250,"unitqtyname":"Gms.","description":null,"is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":35,"name":"DESI GHEE KHAJOOR LADOO","image":"/storage/productimage/Go72zEmvzmPMoZEMd55bn1OiIxd3aHfkrHIPB3AQ.jpg","price":140,"type":"Sweets Only","category_id":2,"is_active":1,"created_at":"2022-09-16T13:37:17.000000Z","updated_at":"2022-09-29T14:53:53.000000Z","unitqty":250,"unitqtyname":"Gms.","description":null,"is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":22,"name":"Desi Ghee Balushahi","image":"/storage/productimage/PnWQN7X1kO7eSGmb0UatS6f1vazv3zzMn0fqPAMz.jpg","price":120,"type":"Price","category_id":2,"is_active":1,"created_at":"2021-09-11T21:10:22.000000Z","updated_at":"2022-09-29T15:25:32.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"Desi Ghee Balushahi","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":21,"name":"Desi Ghee Magdal","image":"/storage/productimage/K7B7gEGMVgkGUpWR7Byjsj8Op7mir26mkFnUnEQH.jpg","price":120,"type":"Price","category_id":2,"is_active":1,"created_at":"2021-09-11T21:09:30.000000Z","updated_at":"2022-09-29T15:29:07.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"Desi Ghee Magdal","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":20,"name":"Desi Ghee patisha Kaju roll","image":"/storage/productimage/IyPuwurnhcFweWmoB9n5m2qx9AbPjmbnkFBXxJVW.webp","price":120,"type":"Price","category_id":2,"is_active":1,"created_at":"2021-09-11T21:08:42.000000Z","updated_at":"2022-09-29T15:30:54.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"Desi Ghee patisha Kaju roll","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":18,"name":"Rasbhari","image":"/storage/productimage/ULplndKY4V09BDrtTr0Upv8xA1ps1ENCvaAddadt.jpg","price":85,"type":"Price","category_id":2,"is_active":1,"created_at":"2021-09-11T21:07:11.000000Z","updated_at":"2022-09-29T15:33:16.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"Rasbhari","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":16,"name":"khoya chana mix sweets","image":"/storage/productimage/nyMPU3yOpIk4y1aQ3gatmvnwnmcRwqiyGKpxBGw6.jpg","price":420,"type":"","category_id":2,"is_active":1,"created_at":"2021-09-11T21:03:55.000000Z","updated_at":"2022-09-13T15:44:43.000000Z","unitqty":1,"unitqtyname":"Kgs.","description":"khoya chana mix sweets","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""}],"first_page_url":"https://mundamisthan.com/api/V1/products/2?page=1","from":1,"last_page":2,"last_page_url":"https://mundamisthan.com/api/V1/products/2?page=2","next_page_url":"https://mundamisthan.com/api/V1/products/2?page=2","path":"https://mundamisthan.com/api/V1/products/2","per_page":10,"prev_page_url":null,"to":10,"total":19}

FoodAllProduct foodAllProductFromJson(String str) => FoodAllProduct.fromJson(json.decode(str));
String foodAllProductToJson(FoodAllProduct data) => json.encode(data.toJson());
class FoodAllProduct {
  FoodAllProduct({
      int? status, 
      ProductData? data,}){
    _status = status;
    _data = data;
}

  FoodAllProduct.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? ProductData.fromJson(json['data']) : null;
  }
  int? _status;
  ProductData? _data;

  int? get status => _status;
  ProductData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// current_page : 1
/// data : [{"id":49,"name":"BLACK JAMUN","image":"/storage/productimage/2CWnWfvvbKbHD96HaaXGeSpCUAkE5HB65jp7cGx1.jpg","price":18,"type":"Sweets Only","category_id":2,"is_active":1,"created_at":"2022-09-16T15:07:08.000000Z","updated_at":"2022-09-30T10:05:34.000000Z","unitqty":1,"unitqtyname":"Pieces","description":"BLACK JAMUN , 18 PER PCS","is_discounted":0,"discounted_price":null,"pin":211003,"qtyname":""},{"id":46,"name":"SUGER KHURMA","image":"/storage/productimage/dgnDZMRiq6PvHgwFwjnvBMukJ0wAZOSDnCqdnStL.jpg","price":60,"type":"Price","category_id":2,"is_active":1,"created_at":"2022-09-16T14:57:13.000000Z","updated_at":"2022-09-16T14:57:13.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"PLASTIC CANTENER PACK 250 GM","is_discounted":0,"discounted_price":null,"pin":211003,"qtyname":""},{"id":37,"name":"DESI GHEE RAJASTHANI LADOO","image":"/storage/productimage/EWxKC2scEAL7n7Vnmc2TVXiXN2I5DJXV6U44nDt2.jpg","price":120,"type":"Price","category_id":2,"is_active":1,"created_at":"2022-09-16T13:47:18.000000Z","updated_at":"2022-09-29T14:49:56.000000Z","unitqty":250,"unitqtyname":"Gms.","description":null,"is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":36,"name":"AATA MEWA LADOO","image":"/storage/productimage/qjcaJbAMKsY1PuZf8FMVZjOCFNtPRCCrA0H0QaiP.jpg","price":140,"type":"Sweets Only","category_id":2,"is_active":1,"created_at":"2022-09-16T13:39:31.000000Z","updated_at":"2022-09-29T14:51:46.000000Z","unitqty":250,"unitqtyname":"Gms.","description":null,"is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":35,"name":"DESI GHEE KHAJOOR LADOO","image":"/storage/productimage/Go72zEmvzmPMoZEMd55bn1OiIxd3aHfkrHIPB3AQ.jpg","price":140,"type":"Sweets Only","category_id":2,"is_active":1,"created_at":"2022-09-16T13:37:17.000000Z","updated_at":"2022-09-29T14:53:53.000000Z","unitqty":250,"unitqtyname":"Gms.","description":null,"is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":22,"name":"Desi Ghee Balushahi","image":"/storage/productimage/PnWQN7X1kO7eSGmb0UatS6f1vazv3zzMn0fqPAMz.jpg","price":120,"type":"Price","category_id":2,"is_active":1,"created_at":"2021-09-11T21:10:22.000000Z","updated_at":"2022-09-29T15:25:32.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"Desi Ghee Balushahi","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":21,"name":"Desi Ghee Magdal","image":"/storage/productimage/K7B7gEGMVgkGUpWR7Byjsj8Op7mir26mkFnUnEQH.jpg","price":120,"type":"Price","category_id":2,"is_active":1,"created_at":"2021-09-11T21:09:30.000000Z","updated_at":"2022-09-29T15:29:07.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"Desi Ghee Magdal","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":20,"name":"Desi Ghee patisha Kaju roll","image":"/storage/productimage/IyPuwurnhcFweWmoB9n5m2qx9AbPjmbnkFBXxJVW.webp","price":120,"type":"Price","category_id":2,"is_active":1,"created_at":"2021-09-11T21:08:42.000000Z","updated_at":"2022-09-29T15:30:54.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"Desi Ghee patisha Kaju roll","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":18,"name":"Rasbhari","image":"/storage/productimage/ULplndKY4V09BDrtTr0Upv8xA1ps1ENCvaAddadt.jpg","price":85,"type":"Price","category_id":2,"is_active":1,"created_at":"2021-09-11T21:07:11.000000Z","updated_at":"2022-09-29T15:33:16.000000Z","unitqty":250,"unitqtyname":"Gms.","description":"Rasbhari","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""},{"id":16,"name":"khoya chana mix sweets","image":"/storage/productimage/nyMPU3yOpIk4y1aQ3gatmvnwnmcRwqiyGKpxBGw6.jpg","price":420,"type":"","category_id":2,"is_active":1,"created_at":"2021-09-11T21:03:55.000000Z","updated_at":"2022-09-13T15:44:43.000000Z","unitqty":1,"unitqtyname":"Kgs.","description":"khoya chana mix sweets","is_discounted":0,"discounted_price":0,"pin":211003,"qtyname":""}]
/// first_page_url : "https://mundamisthan.com/api/V1/products/2?page=1"
/// from : 1
/// last_page : 2
/// last_page_url : "https://mundamisthan.com/api/V1/products/2?page=2"
/// next_page_url : "https://mundamisthan.com/api/V1/products/2?page=2"
/// path : "https://mundamisthan.com/api/V1/products/2"
/// per_page : 10
/// prev_page_url : null
/// to : 10
/// total : 19

ProductData productdataFromJson(String str) => ProductData.fromJson(json.decode(str));
String productdataToJson(ProductData data) => json.encode(data.toJson());
class ProductData {
  ProductData({
      int? currentPage, 
      List<ProductListData>? data,
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      String? nextPageUrl, 
      String? path, 
      int? perPage, 
      dynamic prevPageUrl, 
      int? to, 
      int? total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  ProductData.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProductListData.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  List<ProductListData>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  String? _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  List<ProductListData>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  String? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

/// id : 49
/// name : "BLACK JAMUN"
/// image : "/storage/productimage/2CWnWfvvbKbHD96HaaXGeSpCUAkE5HB65jp7cGx1.jpg"
/// price : 18
/// type : "Sweets Only"
/// category_id : 2
/// is_active : 1
/// created_at : "2022-09-16T15:07:08.000000Z"
/// updated_at : "2022-09-30T10:05:34.000000Z"
/// unitqty : 1
/// unitqtyname : "Pieces"
/// description : "BLACK JAMUN , 18 PER PCS"
/// is_discounted : 0
/// discounted_price : null
/// pin : 211003
/// qtyname : ""

ProductListData productDataFromJson(String str) => ProductListData.fromJson(json.decode(str));
String productDataToJson(ProductListData data) => json.encode(data.toJson());
class ProductListData {
  ProductListData({
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
      dynamic discountedPrice, 
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

  ProductListData.fromJson(dynamic json) {
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
  dynamic _discountedPrice;
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
  dynamic get discountedPrice => _discountedPrice;
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