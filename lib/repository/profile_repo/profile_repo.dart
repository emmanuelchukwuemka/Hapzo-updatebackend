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

  Future<StreamedResponse> createProfile({
    required String userId,
    String? birthDate,
    String? ethnicity,
    String? relationshipStatus,
    String? firstName,
    String? lastName,
    String? bio,
    String? occupation,
    File? profilePicture,
    File? coverPicture,
    String? location,
    String? height,
    String? weight,
  }) async {
    var request =
        MultipartRequest('POST', Uri.parse(ApiConstants.createProfileUrl));

    // Add profile picture if provided
    if (profilePicture != null && await profilePicture.exists()) {
      request.files.add(await MultipartFile.fromPath(
        'profile_picture',
        profilePicture.path,
        filename: profilePicture.path.split('/').last,
      ));
    }

    // Add cover picture if provided
    if (coverPicture != null && await coverPicture.exists()) {
      request.files.add(await MultipartFile.fromPath(
        'cover_picture',
        coverPicture.path,
        filename: coverPicture.path.split('/').last,
      ));
    }

    // 2. Add fields (using a safer map building approach)
    final Map<String, String> fields = {"user_id": userId};

    if (birthDate != null)
      fields["birth_date"] = birthDate.replaceAll('/', '-');
    if (ethnicity != null) fields["ethnicity"] = ethnicity;
    if (relationshipStatus != null)
      fields["relationship_status"] = relationshipStatus;
    if (firstName != null) fields["first_name"] = firstName;
    if (lastName != null) fields["last_name"] = lastName;
    if (bio != null) fields["bio"] = bio;
    if (occupation != null)
      fields["occupation"] = occupation; // Added missing occupation
    if (location != null) fields["location"] = location;
    if (height != null) fields["height"] = height;
    if (weight != null) fields["weight"] = weight;

    request.fields.addAll(fields);
    request.headers.addAll(ApiHeaders.aunthenticatedHeader);

    // 3. Safe Logging
    String fileLog = request.files.isNotEmpty
        ? request.files.first.filename ?? 'file'
        : 'None';
    log("Request to: ${ApiConstants.createProfileUrl}");
    log("Fields: ${request.fields}");
    log("Image Attached: $fileLog");

    return await request.send();
  }

  Future<StreamedResponse> updateProfile(
      {required String userId,
      String? birthDate,
      String? ethnicity,
      String? relationshipStatus,
      String? firstName,
      String? lastName,
      String? bio,
      String? occupation,
      File? profilePicture,
      File? coverPicture,
      String? location,
      String? height,
      String? weight}) async {
    var request =
        MultipartRequest('PUT', Uri.parse(ApiConstants.updateProfileUrl));
    // Add profile picture if provided
    if (profilePicture != null && await profilePicture.exists()) {
      request.files.add(await MultipartFile.fromPath(
        'profile_picture',
        profilePicture.path,
        filename: profilePicture.path.split('/').last,
      ));
    }

    // Add cover picture if provided
    if (coverPicture != null && await coverPicture.exists()) {
      request.files.add(await MultipartFile.fromPath(
        'cover_picture',
        coverPicture.path,
        filename: coverPicture.path.split('/').last,
      ));
    }
    final Map<String, String> fields = {};
    if (birthDate != null) {
      fields["birth_date"] = birthDate.replaceAll('/', '-');
    }
    if (ethnicity != null) fields["ethnicity"] = ethnicity;
    if (relationshipStatus != null) {
      fields["relationship_status"] = relationshipStatus;
    }
    if (firstName != null) fields["first_name"] = firstName;
    if (lastName != null) fields["last_name"] = lastName;
    if (bio != null) fields["bio"] = bio;
    if (occupation != null) {
      fields["occupation"] = occupation;
    }
    if (location != null) fields["location"] = location;
    if (height != null) fields["height"] = height;
    if (weight != null) fields["weight"] = weight;
    request.fields.addAll(fields);
    request.headers.addAll(ApiHeaders.aunthenticatedHeader);
    // 3. Safe Logging
    String fileLog = request.files.isNotEmpty
        ? request.files.first.filename ?? 'file'
        : 'None';
    log("Request to: ${ApiConstants.updateProfileUrl}");
    log("Fields: ${request.fields}");
    log("Image Attached: $fileLog");
    final response = await request.send();
    log("respomse  ${response.statusCode}");
    return response;
  }
}
