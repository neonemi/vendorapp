import 'dart:io';

import 'package:event_bus/event_bus.dart';

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

  // Future<OtpSent> sendOTP({required String mobile}) async {
  //   final Uri api = apiProvider.getUri(Apis.sendOTP);
  //   String body = jsonEncode({'user_phone': mobile, 'app_source': 'customer'});
  //   final response = await apiProvider.post(
  //     endPoint: api,
  //     requestBody: body,
  //     auth: false,
  //   );
  //   OtpSent otpSent = OtpSent.fromJson(response);
  //   return otpSent;
  // }

  //  Future getUserInterestInfo(String key) async {
  //     final Uri api = apiProvider
  //         .getUri(Apis.userInfoInterests, queryParameters: {'key': key});
  //     final response = await apiProvider.get(api);
  //     UserInterestInfo userInfo = UserInterestInfo.fromJson(response);
  //     return userInfo;
  //   }

  Future<bool> logout() {
    return localRepository.clearDatabase();
  }
}
