import 'dart:convert';
import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
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
    String body = jsonEncode({'mobile': mobile, otp: otp});
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
      'is_ios':Platform.isIOS?"1":"0"
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('json register $response');
    }
    RegisterUserResponse registerUserResponse = RegisterUserResponse.fromJson(response);
    if (kDebugMode) {
      print('json 1 $registerUserResponse');
    }
    return RegisterUserResponse.fromJson(response);
  }
   Future getBannerImage() async {
      final Uri api = apiProvider
          .getUri(Apis.bannerImageUrl);
      final response = await apiProvider.get(api);
      print('response 1 $response');
      GetBannerImage bannerImage = GetBannerImage.fromJson(response);
      print('response 2 $bannerImage');
      return bannerImage;
    }

  Future getFoodCategory() async {
    final Uri api = apiProvider
        .getUri(Apis.categoryUrl);
    final response = await apiProvider.get(api);
    print('response 1 $response');
    GetFoodCategory foodCategory = GetFoodCategory.fromJson(response);
    print('response 2 $foodCategory');
    return foodCategory;
  }
  Future<UpdateProfileResponse> updateProfile(
      {required String mobile,
        required String name,
        required String email,
      required String userId,
      required File? imageFile,
      required String? dob,
      required String? anniversary,
      required String? address}) async {
    final Uri api = apiProvider.getUri(Apis.updateProfile);
    String body = jsonEncode({
      'mobile': mobile,
      'name': name,
      'email': email,
      'userid':userId,
      if(imageFile!=null)
      'image':imageFile,
      if(dob!=null)
      'dob':dob,
      if(anniversary!=null)
      'anniversary':anniversary,
      if(address!=null)
      'address':address
    });
    final response = await apiProvider.post(
      requestBody: body,
      endPoint: api,
    );
    if (kDebugMode) {
      print('json update profile $response');
    }
    UpdateProfileResponse updateProfileResponse = UpdateProfileResponse.fromJson(response);
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
}
