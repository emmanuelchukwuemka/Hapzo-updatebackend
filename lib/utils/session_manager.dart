import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:haptext_api/models/user_infor_model.dart';
import 'package:haptext_api/network/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const userProfile = 'profile';
  static const newUserKey = 'newUser';
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  static const _key = 'token';

  Future<bool> checkNewUser() async {
    final prefs = await SharedPreferences.getInstance();
    bool newUser = true;
    final bool? value = prefs.getBool(newUserKey);
    if (value != null) {
      newUser = value;
    } else {
      await prefs.setBool(newUserKey, value ?? false);
    }
    return newUser;
  }

  static clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(newUserKey);
  }

  Future<void> storeToken(String token) async {
    await storage.write(key: _key, value: token);
  }

  Future<String?> getToken() async {
    final token = await storage.read(key: _key);
    if (token != null) {
      bearerToken = token;
      return token;
    } else {
      return null;
    }
  }

  Future<void> deleteToken() async {
    await storage.delete(key: _key);
  }

  //////////////////////userinformation localy stored//////////////////////
  ///////////////////////////////////////////////////////////////////////

  static Future<void> storeUser(UserInfoModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userProfile, jsonEncode(user.toJson()));
  }

  static Future<UserInfoModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(userProfile);
    if (userJson != null) {
      return UserInfoModel.fromJson(jsonDecode(userJson));
    } else {
      return null;
    }
  }

  static Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userProfile);
  }
}
