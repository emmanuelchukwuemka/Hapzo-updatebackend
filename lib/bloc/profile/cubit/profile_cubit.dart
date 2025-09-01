import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/repository/profile_repo/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial()) {
    fetchUserProfile();
  }

  fetchUserProfile() async {
    emit(ProfileLoading());
    try {
      final response = await profileRepo.fetchUserProfile();
      if (response.statusCode == 200) {
        emit(ProfileLoaded());
      } else {
        final body = jsonDecode(response.body);
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(ProfileError());
      }
    } catch (e) {
      emit(ProfileError());
      log("user Profile $e");
    }
  }
}
