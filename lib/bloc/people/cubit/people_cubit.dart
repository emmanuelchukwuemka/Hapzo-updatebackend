import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haptext_api/models/searched_user_model.dart';
import 'package:haptext_api/repository/people_repo/people_repo.dart';
import 'package:haptext_api/utils/toast_helper.dart';
import 'package:meta/meta.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleRepo peopleRepo;
  PeopleCubit(this.peopleRepo) : super(PeopleInitial()) {
    // fetchFriends();
  }

  fetchFriends() async {
    emit(PeopleLoading());
    try {
      final response = await peopleRepo.fetchFriends(page: 1);
      if (response.statusCode == 200) {
        emit(PeopleLoaded());
      } else {
        final body = jsonDecode(response.body);
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(PeopleError());
      }
    } catch (e) {
      emit(PeopleError());
      log("get friends $e");
    }
  }

  fetchUserProfileById(
      {required String userId, bool loggedInUser = false}) async {
    emit(PeopleLoading());
    try {
      final response = await peopleRepo.getUsers(userId: userId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var user in searchedUsers) {
          if (user.id.toString() == userId) {
            user.profile = SearchedUserProfile.fromJson(body['data']);

            emit(PeopleSearched(user: user));
          }
        }
        if (loggedInUser) {
          log("here");
          emit(CurrentUser(user: SearchedUserProfile.fromJson(body['data'])));
        }
      } else {
        final body = jsonDecode(response.body);
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(PeopleError());
      }
    } catch (e) {
      emit(PeopleError());
      log("get Users $e");
    }
  }

  List<SearchedUserModel> searchedUsers = [];
  searchFriends({required String query}) async {
    emit(PeopleLoading());
    try {
      final response = await peopleRepo.searchUsers(query: query, page: 1);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        searchedUsers.clear();
        for (var user in body['data']['users']) {
          searchedUsers.add(SearchedUserModel.fromJson(user));
        }
        emit(PeopleLoaded());
      } else {
        final body = jsonDecode(response.body);
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(PeopleError());
      }
    } catch (e) {
      emit(PeopleError());
      log("get Users $e");
    }
  }

  fetchFollowers({userId}) async {
    emit(PeopleLoading());
    try {
      final response = await peopleRepo.fetchFollowers(page: 1, userId: userId);
      if (response.statusCode == 200) {
        emit(PeopleLoaded());
      } else {
        final body = jsonDecode(response.body);
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(PeopleError());
      }
    } catch (e) {
      emit(PeopleError());
      log("get folowers $e");
    }
  }

  List<SearchedUserProfile> followings = [];
  fetchFollowings({userId}) async {
    emit(PeopleLoading());
    try {
      final response =
          await peopleRepo.fetchFollowings(page: 1, userId: userId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        followings.clear();
        for (var user in body['data']['followings']) {
          followings.add(SearchedUserProfile.fromJson(user));
        }
        emit(PeopleLoaded());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(PeopleError());
      }
    } catch (e) {
      emit(PeopleError());
      log("get folowings $e");
    }
  }

  followUser({userId}) async {
    emit(PeopleFollowing());
    try {
      final response = await peopleRepo.followUser(userId: userId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        ToastMessage.showSuccessToast(message: body['message']);
        for (var user in searchedUsers) {
          if (user.id.toString() == userId) {
            user.following = true;
          }
        }

        emit(PeopleLoaded());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(PeopleError());
      }
    } catch (e) {
      emit(PeopleError());
      log("follow User $e");
    }
  }
}
