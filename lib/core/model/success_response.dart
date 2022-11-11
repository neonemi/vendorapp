class SuccessResponse {
  int? status;
  String? message;
  // String? data;

  SuccessResponse({
      this.status,
      this.message,
     // this.data,
  });

  SuccessResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  //  data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
   // map['data'] = data??"";
    return map;
  }

}