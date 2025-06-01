import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:haptext_api/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceController extends GetxController {
  // var headers = {'Content-Type': 'application/json'};
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // final String baseUrl = 'https://hapztext.onrender.com/api/v1/user';
  //
  // // STORE USER DATA FUNCTION
  // Future<void> storeUserData({required String userId, required String token, required String profileID, required String email, required String username}) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   _prefs.setString('userId', userId);
  //   _prefs.setString('email', email);
  //   _prefs.setString('token', token);
  //   _prefs.setString('userName', username);
  //   _prefs.setString('profile_id', profileID);
  // }
  //
  // // LOGIN FUNCTION
  // Future<bool> signIn() async {
  //   final response = await http.post(
  //       Uri.parse('$baseUrl/login'),
  //       headers: headers,
  //       body: jsonEncode({'email': emailController.text.trim(), 'password': passwordController.text}),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print('Logging in....');
  //     final jsonData = jsonDecode(response.body);
  //     print('Body: ');
  //     print(jsonData);
  //     var user = UserModel.fromJson(jsonData);
  //
  //     // STORE USER DATA FUNCTION CALLED HERE
  //     print('Storing user data locally');
  //     await storeUserData(userId: user.id, token: user.token!, profileID: jsonData['profile_id'], email: jsonData['email'], username: user.tagname);
  //     print('Stored user data successfully');
  //
  //     emailController.clear();
  //     passwordController.clear();
  //
  //     Get.to(() => const OTPVerification());
  //     return true;
  //   } else {
  //     print('Something went wrong, status code is not 200');
  //     return false;
  //   }
  // }

  // AUTH CHECK

  Future<bool> isLoggedIn() async {
    final _prefs = await SharedPreferences.getInstance();
    final email = _prefs.getString('email');
    final token = _prefs.getString('token');
    return token != null && email != null;
  }

  // // REMOVE USER DATA
  // Future<void> removeUserData() async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   _prefs.remove('email');
  //   _prefs.remove('token');
  // }
  //
  // // LOGOUT FUNCTION
  // Future<void> signOut() async {
  //   print('Logging out...');
  //   removeUserData();
  // }
}