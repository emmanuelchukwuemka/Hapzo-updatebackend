import 'package:get/get.dart';
import 'package:haptext_api/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;

  // REMOVE USER DATA
  Future<void> removeUserData() async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove('email');
    _prefs.remove('token');
  }

  // LOGOUT FUNCTION
  Future<void> signOut() async {
    _isLoading.value = true;
    print('Logging out...');
    removeUserData();
    _isLoading.value = false;
    Get.offAll(() => SignIn());
  }
}