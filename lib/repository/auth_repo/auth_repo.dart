import 'package:haptext_api/network/api_constants.dart';
import 'package:haptext_api/network/api_helper.dart';
import 'package:http/http.dart';

class AuthRepo {
  Future<Response> registerUser(
      {required String username,
      required String email,
      required String password,
      required String passwordConfirm}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.register,
        body: {
          "username": username,
          "email": email,
          "password": password,
          "password_confirm": passwordConfirm
        },
        headers: ApiHeaders.unaunthenticatedHeader);
  }

  Future<Response> verifyUserEmail(
      {required String email, required String otp}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.verifyEmailUrl,
        body: {"email": email, "otp_code": int.parse(otp)},
        headers: ApiHeaders.unaunthenticatedHeader);
  }

  Future<Response> userLogin(
      {required String email, required String password}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.login,
        body: {"email": email, "password": password},
        headers: ApiHeaders.unaunthenticatedHeader);
  }

  Future<Response> requestPasswordReset({required String email}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.requestPasswordReset,
        body: {"email": email},
        headers: ApiHeaders.unaunthenticatedHeader);
  }

  Future<Response> requestEmailVerify({required String email}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.verifyEmailRequestUrl,
        body: {"email": email, "purpose": "email_verification"},
        headers: ApiHeaders.unaunthenticatedHeader);
  }

  Future<Response> resetPassword(
      {required String email,
      required String newPassword,
      required String otp,
      required String confirmNewPassword}) async {
    return await ApiMethods.postMethod(
        url: ApiConstants.verifyPasswordReset,
        body: {
          "email": email,
          "code": otp,
          "new_password": newPassword,
          "new_password_confirm": confirmNewPassword
        },
        headers: ApiHeaders.unaunthenticatedHeader);
  }
}
