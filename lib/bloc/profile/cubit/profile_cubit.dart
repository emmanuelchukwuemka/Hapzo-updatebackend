import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:haptext_api/exports.dart';
import 'package:haptext_api/repository/profile_repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  createProfile(
      {required String userId,
      String? birthDate,
      String? ethnicity,
      String? relationshipStatus,
      String? firstName,
      String? lastName,
      String? bio,
      String? occupation,
      File? profilePicture,
      bool updateProfile = false,
      String? location,
      String? height,
      String? weight}) async {
    emit(ProfileLoading());
    try {
      final response = updateProfile
          ? await profileRepo.updateProfile(
              userId: userId,
              birthDate: birthDate,
              ethnicity: ethnicity,
              relationshipStatus: relationshipStatus,
              firstName: firstName,
              lastName: lastName,
              profilePicture: profilePicture,
              bio: bio,
              occupation: occupation,
              location: location,
              height: height,
              weight: weight)
          : await profileRepo.createProfile(
              userId: userId,
              birthDate: birthDate,
              ethnicity: ethnicity,
              relationshipStatus: relationshipStatus,
              firstName: firstName,
              lastName: lastName,
              profilePicture: profilePicture,
              bio: bio,
              occupation: occupation,
              location: location,
              height: height,
              weight: weight);
      final body = jsonDecode(await response.stream.bytesToString());

      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 202) {
        emit(ProfileUpdated());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(ProfileError());
      }
    } catch (e) {
      emit(ProfileError());
      log("create Profile $e");
    }
  }
}
