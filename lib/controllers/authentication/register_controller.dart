import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:haptext_api/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  final RxBool _isLoading = false.obs;
  get isLoading => _isLoading.value;

  // STORE USER DATA FUNCTION
  // Future<void> storeUserData({required String userId, required String email, required String username}) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   _prefs.setString('userId', userId);
  //   _prefs.setString('email', email);
  //   _prefs.setString('userName', username);
  // }

  Future<bool> registerWithEmail() async {
    if (usernameController.text.isEmpty || emailController.text.isEmpty ||
        password1Controller.text.isEmpty || password2Controller.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
    }
    _isLoading.value = true;

    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          'https://hapztext.onrender.com/api/v1/user/register/');
      Map body = {
        'username': usernameController.text,
        'email': emailController.text.trim(),
        'password1': password1Controller.text,
        'password2': password2Controller.text,
      };

      print('Creating body');
      final http.Response response = await http.Client().post(
          url, body: jsonEncode(body), headers: headers);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        var user = UserModel.fromJson(json);
        print('Registration successful');

        // STORE USER DATA FUNCTION CALLED HERE
        // print('Storing user data locally');
        // await storeUserData(userId: user.id, email: json['email'], username: user.tagname);
        // print('Stored user data successfully');

        _isLoading.value = false;
        Get.to(() => const OTPVerification());
        return true;
      } else {
        print('Something went wrong... status code is not 200');
        _isLoading.value = false;
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occurred";
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }
}