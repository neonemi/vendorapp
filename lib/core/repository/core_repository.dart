import 'dart:convert';
import 'dart:io';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../core.dart';

/// User authentication API call goes here
class CoreRepository {
  CoreRepository({required this.localRepository}) {
    eventBus = EventBus();
    _apiProvider = ApiProvider(
      eventBus: eventBus,
      token: localRepository.getToken(),
    );
  }

  final LocalRepository localRepository;

  ApiProvider? _apiProvider;
  final List<File> landingPageFiles = [];
  late final EventBus eventBus;
  bool ret = false;

  ApiProvider get apiProvider => _apiProvider!;

  Future<OtpResponse> sendOTP({required String mobile}) async {
    final Uri api = apiProvider.getUri(Apis.sendOtp);
    String body = jsonEncode({
      'mobile': mobile,
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('json$response');
    }
    OtpResponse otpSent = OtpResponse.fromJson(response);
    if (kDebugMode) {
      print('json 1 $otpSent');
    }
    return OtpResponse.fromJson(response);
  }

  Future<OtpVerifyResponse> verifyOTP(
      {required String mobile, required String otp}) async {
    final Uri api = apiProvider.getUri(Apis.otpVerify);
    String body = jsonEncode({'mobile': mobile, 'otp': otp});
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('json$response');
    }
    OtpVerifyResponse otpSent = OtpVerifyResponse.fromJson(response);
    if (kDebugMode) {
      print('json 1 $otpSent');
    }
    return OtpVerifyResponse.fromJson(response);
  }

  Future<RegisterUserResponse> registerUser(
      {required String mobile,
        required String name,
        required String email}) async {
    final Uri api = apiProvider.getUri(Apis.registerUrl);
    String body = jsonEncode({
      'mobile': mobile,
      'name': name,
      'email': email,
      'is_ios': Platform.isIOS ? "1" : "0"
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('json register $response');
    }
    RegisterUserResponse registerUserResponse =
    RegisterUserResponse.fromJson(response);
    if (kDebugMode) {
      print('json 1 $registerUserResponse');
    }
    return RegisterUserResponse.fromJson(response);
  }
  Future updateToken(
      {required String userId, required String token}) async {
    final Uri api = apiProvider.getUri(Apis.updateToken);
    String body = jsonEncode({'userid': userId, 'token': token, 'is_ios':Platform.isIOS?'1':'0'});
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('json$response');
    }
    SuccessResponse successResponse = SuccessResponse.fromJson(response);
    if (kDebugMode) {
      print('json 1 $successResponse');
    }
    return successResponse;
  }
  Future getBannerImage() async {
    final Uri api = apiProvider.getUri(Apis.bannerImageUrl);
    final response = await apiProvider.get(api);
    debugPrint('response 1 $response');
    GetBannerImage bannerImage = GetBannerImage.fromJson(response);
    debugPrint('response 2 $bannerImage');
    return bannerImage;
  }

  Future getFoodCategory() async {
    final Uri api = apiProvider.getUri(Apis.categoryUrl);
    final response = await apiProvider.get(api);
    debugPrint('response 1 $response');
    GetFoodCategory foodCategory = GetFoodCategory.fromJson(response);
    debugPrint('response 2 $foodCategory');
    return foodCategory;
  }

  Future<UpdateProfileResponse> updateProfile(
      {required String name,
        required String email,
        required File? imageFile,
        required DateTime? dob,
        required DateTime? anniversary}) async {
    final Uri api = apiProvider.getUri(Apis.updateProfile);
    String address = await localRepository.getAddress();
    String mobile = await localRepository.getMobile();
    String userId = await localRepository.getUserId();
    String body = jsonEncode({
      'mobile': mobile,
      'name': name,
      'email': email,
      'userid': userId,
      if (imageFile != null) 'image': imageFile,
      if (dob != null) 'dob': dob.toString(),
      if (anniversary != null) 'anniversary': anniversary.toString(),
      if (address.isNotEmpty) 'address': address
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('json update profile $response');
    }
    UpdateProfileResponse updateProfileResponse =
    UpdateProfileResponse.fromJson(response);
    if (kDebugMode) {
      print('json 1 $updateProfileResponse');
    }
    return UpdateProfileResponse.fromJson(response);
  }

  Future<UpdateProfileResponse> updateProfileFile(
      {required String name,
        required String email,
        required File? imageFile,
        required DateTime? dob,
        required DateTime? anniversary}) async {
    final Uri api = apiProvider.getUri(Apis.updateProfile);
    String address = await localRepository.getAddress();
    String mobile = await localRepository.getMobile();
    String userId = await localRepository.getUserId();

    var request = http.MultipartRequest("POST", api);
    request.fields['mobile'] = mobile;
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['userid'] = userId;
    if (dob != null) {
      request.fields['dob'] = dob.toString();
    }
    if (anniversary != null) {
      request.fields['anniversary'] = anniversary.toString();
    }
    if (address.isNotEmpty) {
      request.fields['address'] = address;
    }
    if (kDebugMode) {
      print(imageFile!.path);
    }
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile!.path));
    final response = await apiProvider.postMultipart(request: request);
    UpdateProfileResponse updateProfileResponse =
    UpdateProfileResponse.fromJson(response);
    if (kDebugMode) {
      print('json 1 $updateProfileResponse');
    }
    return UpdateProfileResponse.fromJson(response);
  }

//  Future getBannerImage(String key) async {
//       final Uri api = apiProvider
//           .getUri(Apis.bannerImageUrl, queryParameters: {'key': key});
//       final response = await apiProvider.get(api);
//       UserInterestInfo userInfo = UserInterestInfo.fromJson(response);
//       return userInfo;
//     }
  Future<bool> logout() {
    return localRepository.clearDatabase();
  }

//https://mundamisthan.com/api/V1/products/2?sortbyprice=asc&type=1
  //.getUri('${Apis.allProductUrl}/$id?sortbyprice=$sortBy&type=$type'
  Future getFoodProductFilter(String id, String sortBy, String type) async {
    final Uri api = apiProvider.getUri('${Apis.allProductUrl}/$id',
        queryParameters: {'sortbyprice': sortBy, 'type': type});
    final response = await apiProvider.get(api);
    debugPrint('response 1 $response');
    FoodAllProduct foodCategory = FoodAllProduct.fromJson(response);
    debugPrint('response 2 $foodCategory');
    return foodCategory;
  }

  Future getFoodAllProduct(String id, String sortBy, String type) async {
    // final Uri api = apiProvider.getUri('${Apis.allProductUrl}/$id');
    final Uri api = apiProvider.getUri('${Apis.allProductUrl}/$id',
        queryParameters: {
          if (sortBy.isNotEmpty) 'sortbyprice': sortBy,
          if (type.isNotEmpty) 'type': type
        });
    final response = await apiProvider.get(api);
    debugPrint('response 1 $response');
    FoodAllProduct foodCategory = FoodAllProduct.fromJson(response);
    debugPrint('response 2 $foodCategory');
    return foodCategory;
  }
  Future getSubCategory(String id) async {
    // final Uri api = apiProvider.getUri('${Apis.allProductUrl}/$id');
    final Uri api = apiProvider.getUri('${Apis.subCategory}/$id');
    final response = await apiProvider.get(api);
    debugPrint('response 1 $response');
    GetSubCategory foodCategory = GetSubCategory.fromJson(response);
    debugPrint('response 2 $foodCategory');
    return foodCategory;
  }
  Future getFoodBestSeller(String id) async {
    final Uri api = apiProvider.getUri('${Apis.bestSellerUrl}/$id');
    final response = await apiProvider.get(api);
    debugPrint('response 1 $response');
    GetBestSellerResponse foodCategory =
    GetBestSellerResponse.fromJson(response);
    debugPrint('response 2 $foodCategory');
    return foodCategory;
  }

  Future getFilter() async {
    final Uri api = apiProvider.getUri(Apis.filterUrl);
    final response = await apiProvider.get(api);
    debugPrint('response 1 $response');
    FilterResponse filterResponse = FilterResponse.fromJson(response);
    debugPrint('response 2 $filterResponse');
    return filterResponse;
  }

  Future<GetSearchProduct> getSearchProduct({required String text}) async {
    final Uri api = apiProvider.getUri(Apis.searchUrl);
    String body = jsonEncode({'q': text});
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('json$response');
    }
    GetSearchProduct getSearchProduct = GetSearchProduct.fromJson(response);
    if (kDebugMode) {
      print('json 1 $getSearchProduct');
    }
    return getSearchProduct;
  }

  Future addAddress(
      {required String userid,
        required String address,
        required String location,
        required String lat,
        required String lng,
        required String floor,
        required String landmark,
        required String pincode}) async {
    final Uri api = apiProvider.getUri(Apis.addAddressUrl);
    String body = jsonEncode({
      'userid': userid,
      'address': address,
      'location': location,
      'lat': lat,
      'lng': lng,
      'floor': floor,
      'landmark': landmark,
      'pincode': pincode
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('json$response');
    }
    SuccessResponse successResponse = SuccessResponse.fromJson(response);
    if (kDebugMode) {
      print('json 1 $successResponse');
    }
    return successResponse;
  }

  Future updateAddress({
    required String userid,
    required String address,
    required String location,
    required String lat,
    required String lng,
    required String floor,
    required String addressId,
  }) async {
    final Uri api = apiProvider.getUri(Apis.updateAddressUrl);
    String body = jsonEncode({
      'userid': userid,
      'address': address,
      'location': location,
      'lat': lat,
      'lng': lng,
      'floor': floor,
      'addressid': addressId
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('updateAddress json$response');
    }
    SuccessResponse successResponse = SuccessResponse.fromJson(response);
    if (kDebugMode) {
      print('updateAddress json 1 $successResponse');
    }
    return successResponse;
  }

  Future defaultAddress({
    required String addressId,
    required String userid,
  }) async {
    final Uri api = apiProvider.getUri(Apis.defaultaddressUrl);
    String body = jsonEncode({'userid': userid, 'addressid': addressId});
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('defaultAddress json$response');
    }
    SuccessResponse successResponse = SuccessResponse.fromJson(response);
    if (kDebugMode) {
      print('defaultAddress json 1 $successResponse');
    }
    return successResponse;
  }

  Future deleteAddress({required String addressId}) async {
    final Uri api = apiProvider.getUri(Apis.deleteaddressUrl);
    String body = jsonEncode({'addressid': addressId});
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('deleteAddress json$response');
    }
    SuccessResponse successResponse = SuccessResponse.fromJson(response);
    if (kDebugMode) {
      print('deleteAddress json 1 $successResponse');
    }
    return successResponse;
  }
  Future getAllAddress(String id) async {
    final Uri api = apiProvider.getUri('${Apis.allAddressUrl}/$id');
    final response = await apiProvider.get(api);
    debugPrint('getAllAddress response 1 $response');
    GetAllAddressResponse successResponse =
    GetAllAddressResponse.fromJson(response);
    debugPrint('getAllAddress response 2 $successResponse');
    return successResponse;
  }
  Future getCoupon() async {
    final Uri api = apiProvider.getUri(Apis.couponUrl);
    final response = await apiProvider.get(api);
    debugPrint('getCoupon response 1 $response');
    GetCouponResponse successResponse =
    GetCouponResponse.fromJson(response);
    debugPrint('getCoupon response 2 $successResponse');
    return successResponse;
  }
  Future getNotifications(String id) async {
    final Uri api = apiProvider.getUri('${Apis.notificationUrl}/$id');
    final response = await apiProvider.get(api);
    debugPrint('getNotifications response 1 $response');
    GetNotificationResponse successResponse =
    GetNotificationResponse.fromJson(response);
    debugPrint('getNotifications response 2 $successResponse');
    return successResponse;
  }


  Future deleteNotifications(String id) async {
    final Uri api = apiProvider.getUri('${Apis.notificationUrl}/$id');
    final response = await apiProvider.delete(api);
    debugPrint('deleteNotifications response 1 $response');
    GetNotificationResponse successResponse =
    GetNotificationResponse.fromJson(response);
    debugPrint('deleteNotifications response 2 $successResponse');
    return successResponse;
  }
  Future readNotifications(String id) async {
    final Uri api = apiProvider.getUri('${Apis.readNotificationUrl}/$id');
    final response = await apiProvider.get(api);
    debugPrint('readNotifications response 1 $response');
    GetNotificationResponse successResponse =
    GetNotificationResponse.fromJson(response);
    debugPrint('readNotifications response 2 $successResponse');
    return successResponse;
  }
  Future unReadCountNotifications(String id) async {
    final Uri api = apiProvider.getUri('${Apis.unReadCountNotificationUrl}/$id');
    final response = await apiProvider.get(api);
    debugPrint('unReadCountNotifications response 1 $response');
    GetUnReadNotificationCount successResponse =
    GetUnReadNotificationCount.fromJson(response);
    debugPrint('unReadCountNotifications response 2 $successResponse');
    return successResponse;
  }
  Future order(
      {required String mobile,
        required String name,
        required String address,
        required String products,
        required String cartamount,
        required String coupon,
        required String finalamount}) async {
    final Uri api = apiProvider.getUri(Apis.orderUrl);
    String body = jsonEncode({
      'mobile': mobile,
      'name': name,
      'address': address,
      'products': products, //[{"id":1,"name":"Gulab jamun","qty":1,"unitqty":1,"unitqtyname":"Pieces","unitprice":1,"price":1}]
      'cartamount': cartamount,
      'coupon': coupon,
      'finalamount': finalamount
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('order json :$response');
    }
    GetOrderResponse orderResponse = GetOrderResponse.fromJson(response);
    if (kDebugMode) {
      print('order json 1: $orderResponse');
    }
    return orderResponse;
  }
  Future customerOrders(
      {required String mobile}) async {
    final Uri api = apiProvider.getUri(Apis.customerOrderUrl);
    String body = jsonEncode({
      'mobile': mobile
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('customerOrders response: $response');
    }
    GetCustomerOrderResponse getCustomOrderResponse = GetCustomerOrderResponse.fromJson(response);
    if (kDebugMode) {
      print('customerOrders response 1 : $getCustomOrderResponse');
    }
    return getCustomOrderResponse;
  }
  Future<GetTrackOrderResponse> trackOrders(
      {required String orderId}) async {
    final Uri api = apiProvider.getUri(Apis.trackOrderUrl);
    String body = jsonEncode({
      'order_id': orderId
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('trackOrders response : $response');
    }
    GetTrackOrderResponse successResponse = GetTrackOrderResponse.fromJson(response);
    if (kDebugMode) {
      print('trackOrders response 1 :  $successResponse');
    }
    return GetTrackOrderResponse.fromJson(response);
  }

  Future paymentPayload(
      {required String orderId,required String userId,required String transactionId,required paymentStatus }) async {
    final Uri api = apiProvider.getUri(Apis.paymentPayloadUrl);
    String body = jsonEncode({
      'order_id': orderId,
      'userid':userId,
      'transaction_id':transactionId,
      'payment_status':paymentStatus
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('paymentPayload response: $response');
    }
    GetPaymentPayloadResponse getPaymentPayloadResponse = GetPaymentPayloadResponse.fromJson(response);
    if (kDebugMode) {
      print('paymentPayload response 1 : $getPaymentPayloadResponse');
    }
    return getPaymentPayloadResponse;
  }
}
