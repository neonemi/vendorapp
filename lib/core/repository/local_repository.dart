import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  static LocalRepository? _instance;
  static SharedPreferences? _preferences;

  LocalRepository._internal();

  static Future<LocalRepository> get instance async {
    _instance ??= LocalRepository._internal();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  ///Clear all local DB
  ///Call this on logout
  Future<bool> clearDatabase() async {
    return await _preferences!.clear();
  }

  Future<bool> saveToken(String token) {
    return _preferences!.setString(SharedPrefKeys.token, token);
  }

  String getToken() {
    return _preferences!.getString(SharedPrefKeys.token) ?? '';
  }
  //Chat preferences
  setLogin(bool login) async {
    return _preferences!.setBool(SharedPrefKeys.loginConstant, login);
  }

  Future<bool> isLoggedIn() async {
    bool loggedIn =
        (_preferences!.getBool(SharedPrefKeys.loginConstant) ?? false);
    return loggedIn;
  }

  setCount(String count) async {
    return _preferences!.setString(SharedPrefKeys.countConstant, count);
  }

  getCount() async {
    var count = (_preferences!.getString(SharedPrefKeys.countConstant) ?? "");
    return count;
  }


  setFcmToken(String fcmToken) async {
    return _preferences!.setString(SharedPrefKeys.fcmTokenConstant, fcmToken);
  }

  getFcmToken() async {
    var fcmToken =
        (_preferences!.getString(SharedPrefKeys.fcmTokenConstant) ?? "");
    return fcmToken;
  }

  setIsRegistered(bool register) async {
    return _preferences!
        .setBool(SharedPrefKeys.isDeviceRegisteredConstant, register);
  }

  isRegistered() async {
    var isRegister =
        (_preferences!.getBool(SharedPrefKeys.isDeviceRegisteredConstant) ??
            false);
    return isRegister;
  }

  setUserImage(String profile) async {
    return _preferences!.setString(SharedPrefKeys.profileConstant, profile);
  }

  getUserImage() async {
    var userImage =
        (_preferences!.getString(SharedPrefKeys.profileConstant) ?? "");
    return userImage;
  }

  setUserName(String username) async {
    return _preferences!.setString(SharedPrefKeys.usernameConstant, username);
  }

  String getUserName() {
    var username =
        (_preferences!.getString(SharedPrefKeys.usernameConstant) ?? "");
    return username;
  }

  setPassword(String password) async {
    return _preferences!.setString(SharedPrefKeys.passwordConstant, password);
  }

  getPassword() async {
    var password =
        (_preferences!.getString(SharedPrefKeys.passwordConstant) ?? "");
    return password;
  }

  setProfileComplete(String isYes) async {
    return _preferences!
        .setString(SharedPrefKeys.profileCompleteConstant, isYes);
  }

 Future<String> getProfileComplete() async {
    String profileComplete =
        (_preferences!.getString(SharedPrefKeys.profileCompleteConstant) ?? "");
    return profileComplete;
  }

  setUserId(String userId) async {
    return _preferences!.setString(SharedPrefKeys.userIdConstant, userId);
  }

  getUserId() async {
    var userid = (_preferences!.getString(SharedPrefKeys.userIdConstant) ?? "");
    return userid;
  }

}

/// Add keys which will be used in
class SharedPrefKeys {
  SharedPrefKeys._();

  static const String token = "token";
  static const loginConstant = "LOGIN";
  static const userTokenConstant = "USER_TOKEN";

  static const profileConstant = "PROFILE";
  static const usernameConstant = "USERNAME";
  static const profileCompleteConstant = "PROFILE_COMPLETE";
  static const fcmTokenConstant = "FCM_TOKEN";
  static const userIdConstant = "USERID";
  static const passwordConstant = "PASSWORD";
  static const countConstant = "COUNT";
  static const isDeviceRegisteredConstant = "IS_THIS_REGISTERED";

}