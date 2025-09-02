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
    emit(ProfileLoading());
    try {
      final response = await profileRepo.createProfile(
          userId: userId,
          birthDate: birthDate,
          ethnicity: ethnicity,
          relationshipStatus: relationshipStatus,
          firstName: firstName,
          lastName: lastName,
          bio: bio,
          occupation: occupation,
          profilePicture: profilePicture,
          location: location,
          height: height,
          weight: weight);
      // final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        emit(ProfileLoaded());
      } else {
        final body = jsonDecode(await response.stream.bytesToString());
        log("bo$body");
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
