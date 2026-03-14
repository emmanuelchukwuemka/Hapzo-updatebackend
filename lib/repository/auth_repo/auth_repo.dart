import 'dart:io';
import 'package:haptext_api/network/api_constants.dart';
import 'package:haptext_api/network/api_helper.dart';
import 'package:http/http.dart';

class AuthRepo {
  Future<StreamedResponse> registerUser(
      {required String username,
      required String email,
      required String password,
      String? firstName,
      String? lastName,
      String? gender,
      String? birthDate,
      String? location,
      String? relationshipStatus,
      String? occupation,
      File? profilePicture,
      required String passwordConfirm}) async {
    
    var request = MultipartRequest('POST', Uri.parse(ApiConstants.register));

    if (profilePicture != null && await profilePicture.exists()) {
      request.files.add(await MultipartFile.fromPath(
        'profile_picture',
        profilePicture.path,
        filename: profilePicture.path.split('/').last,
      ));
    }

    final Map<String, String> fields = {
      "username": username,
      "email": email,
      "password": password,
      "password_confirm": passwordConfirm
    };

    if (firstName != null) fields["first_name"] = firstName;
    if (lastName != null) fields["last_name"] = lastName;
    if (gender != null) fields["gender"] = gender;
    if (birthDate != null) fields["birth_date"] = birthDate.replaceAll('/', '-');
    if (location != null) fields["location"] = location;
    if (relationshipStatus != null) fields["relationship_status"] = relationshipStatus;
    if (occupation != null) fields["occupation"] = occupation;

    request.fields.addAll(fields);
    request.headers.addAll(ApiHeaders.unaunthenticatedHeader);

    return await request.send();
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
