import 'dart:convert';
/// status : 200
/// data : [{"image":"/storage/bannerimage/7id6vg9g0l3ZqMqgypOixv6LsvBkDiv3eLk3tHFM.jpeg"},{"image":"/storage/bannerimage/4thvF3hZXSN566ggDc43pQXLimFBJwmARXvmwV4V.jpeg"},{"image":"/storage/bannerimage/L6SBB86ZIXf0gYIecu9lYse3Ud2i2JBkdGuFiCoT.jpg"},{"image":"/storage/bannerimage/QnD6rB1iHNMWDuWsYqCc67WaYRvYyext6QtDM3CZ.jpg"},{"image":"/storage/bannerimage/w95JtgKmMWj0wMvJO10vXbZDlOUsG5XXgrWgZxAD.jpg"},{"image":"/storage/bannerimage/UQlmiVQKuYom6vgIdVzmoqK1t0XOFgLvzGlaaX68.png"}]

GetBannerImage getBannerImageFromJson(String str) => GetBannerImage.fromJson(json.decode(str));
String getBannerImageToJson(GetBannerImage data) => json.encode(data.toJson());
class GetBannerImage {
  GetBannerImage({
      int? status, 
      List<BannerData>? data,}){
    _status = status;
    _data = data;
}

  GetBannerImage.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BannerData.fromJson(v));
      });
    }
  }
  int? _status;
  List<BannerData>? _data;

  int? get status => _status;
  List<BannerData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// image : "/storage/bannerimage/7id6vg9g0l3ZqMqgypOixv6LsvBkDiv3eLk3tHFM.jpeg"

BannerData bannerDataFromJson(String str) => BannerData.fromJson(json.decode(str));
String bannerDataToJson(BannerData data) => json.encode(data.toJson());
class BannerData {
  BannerData({
      String? image,}){
    _image = image;
}

  BannerData.fromJson(dynamic json) {
    _image = json['image'];
  }
  String? _image;

  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    return map;
  }

}