import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:haptext_api/exports.dart';
import '../../utils/user_utils.dart';

class LoginController extends GetxController {
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> loginWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse('https://hapztext.onrender.com/api/v1/user/login/');
      // var url = Uri.parse('https://reqres.in/api/login/');

      _isLoading.value = true;
      print('making body');
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };
      print('body: $body');
      // print(body);

      final response = await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        print('Logging in');
        final json = jsonDecode(response.body);
        var user = UserModel.fromJson(json);
        print(json);

        // STORE USER DATA FUNCTION CALLED HERE
        print('Storing user data locally');
        await storeUserData(userId: user.id, token: user.token!, profileID: json['profile_id'], email: json['email'], username: user.tagname);
        print('Stored user data successfully');

        emailController.clear();
        passwordController.clear();

        _isLoading.value = false;
        // GO TO HOME
        // Get.off(HomeScreen());
        Get.offAll(() => const Home());
      return true;
      } else {
        _isLoading.value = false;
        print('Something went wrong, status code ain\'t 200');
        print(jsonDecode(response.body));
        // throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
        showDialog(context: Get.context!, builder: (context) {
          return SimpleDialog(
            title: const Text('Error'),
            contentPadding: const EdgeInsets.all(20),
            children: [Text(jsonDecode(response.body))],
          );
        });
      }

    } catch (e) {
      Get.back();
      showDialog(context: Get.context!, builder: (context) {
        return SimpleDialog(
          title: const Text('Error'),
          contentPadding: const EdgeInsets.all(20),
          children: [Text(e.toString())],
        );
      });
    }
      return false;
  }
}