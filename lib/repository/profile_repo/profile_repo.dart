import 'dart:developer';
import 'dart:io';
import 'package:haptext_api/network/api_constants.dart';
import 'package:haptext_api/network/api_helper.dart';
import 'package:http/http.dart';

class ProfileRepo {
  Future<Response> fetchUserProfile() async {
    return await ApiMethods.getMethod(
        url: ApiConstants.userProfileBaseUrl,
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<StreamedResponse> createProfile(
      {required String userId,
      required String birthDate,
      required String ethnicity,
      required String relationshipStatus,
      required String firstName,
      required String lastName,
      required String bio,
      required String occupation,
      required File profilePicture,
      required String location,
      required String height,
      required String weight}) async {
    var request =
        MultipartRequest('POST', Uri.parse(ApiConstants.createProfileUrl));
    request.files.add(await MultipartFile.fromPath(
        'profile_picture', profilePicture.path,
        filename: profilePicture.path.split('/').last));
    String date = birthDate.replaceAll('/', '-').toString();
    request.fields.addAll({
      "user_id": userId,
      "birth_date": date,
      "ethnicity": ethnicity,
      "relationship_status": relationshipStatus,
      "first_name": firstName,
      "last_name": firstName,
      "bio": bio,
      "location": location,
      "height": height,
      "weight": weight
    });
    request.headers.addAll(ApiHeaders.aunthenticatedHeader);
    log("Payload ${request.fields.entries} media${request.files.first.field}");
    return await request.send();
  }
}
