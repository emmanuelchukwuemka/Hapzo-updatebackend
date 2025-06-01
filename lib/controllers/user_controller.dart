import 'dart:convert';
import 'package:get/get.dart';
import '../utils/user_utils.dart';
import 'package:http/http.dart' as http;
import 'package:haptext_api/exports.dart';


class UserController extends GetxController {
  RxBool isLoading = false.obs;

  Future<UserModel?> fetchUserData() async {
    isLoading.value = true;
    var token = await getUserToken();
    var profileId = await getProfileId();

    final response = await http.get(
      Uri.parse("https://hapztext.onrender.com/api/v1/user/profile/$profileId/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
    );
    print (token);
    print (profileId);
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      // Profile updated successfully
      print('Getting profile details now...');
      final jsonData = jsonDecode(response.body);
      isLoading.value = false;
      print('Done');

      final userModel = UserModel.fromJson(jsonData);
      return userModel;
    } else {
      // Profile update failed
      print('Update failed');
      isLoading.value = false;
      return null;
    }
  }

  // Future<void> fetchUserData(UserModel userData) async {
    // final prefs = await SharedPreferences.getInstance();
    // final userId = prefs.getString('userId');
    // final email = prefs.getString('email');
    // final userName = prefs.getString('userName');

    // userData = UserModel(id: userId!, tagname: userName!);
    // var _url = Uri.parse('https://hapztext.onrender.com/api/v1/user/detail/{user_id}/');
    // final http.Response response = await http.Client().get(_url);
    // if(response.statusCode == 200) {}
  // }
}