import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:haptext_api/exports.dart';
import 'package:haptext_api/repository/home_repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial()) {
    fetchPosts();
  }

  int page = 1;
  PostModel posts = PostModel();
  fetchPosts() async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.fetchPost(page: page);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        posts = PostModel.fromJson(body['data']);
        emit(HomeLoaded());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("fetch post $e");
    }
  }

  Future<List<ResultPostModel>?> fetchUserPosts({userId}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.fetchUserPost(page: page, userId: userId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<ResultPostModel> posts = [];
        for (var post in body['data']['result']) {
          posts.add(ResultPostModel.fromJson(post));
        }
        emit(HomeLoaded());
        return posts;
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
        return null;
      }
    } catch (e) {
      emit(HomeError());
      log("fetch post $e");
      return null;
    }
  }

  sharePost({postId}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.sharePost(id: postId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        emit(PostShared());
        fetchPosts();
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("share post $e");
    }
  }

  reactToPost({postId}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.reactPost(id: postId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        emit(PostReact());
        fetchPosts();
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("react post $e");
    }
  }

  fetchNotification() async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.fetchNotification(page: 1);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(HomeLoaded());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("fetch notification $e");
    }
  }

  createTextPost({String? textContent}) async {
    emit(HomeLoading());
    try {
      final response =
          await homeRepo.createTextPost(textContent: textContent ?? "");
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        emit(HomePostCreated());
        await Future.delayed(const Duration(seconds: 2));

        fetchPosts();
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("create Text post $e");
    }
  }

  createAudioPost({required File audio}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.createAudioPost(audioFile: audio);
      if (response.statusCode == 201) {
        emit(HomePostCreated());
        fetchPosts();
      } else {
        final body = jsonDecode(await response.stream.bytesToString());
        log("message$body");
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("create audio post $e");
    }
  }

  createImagePost({required File image, required caption}) async {
    emit(HomeLoading());
    try {
      final response =
          await homeRepo.createImagePost(image: image, caption: caption);
      if (response.statusCode == 201) {
        emit(HomePostCreated());
        fetchPosts();
      } else {
        final body = jsonDecode(await response.stream.bytesToString());
        log("message$body");
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("create audio post $e");
    }
  }

  createVideoPost({required File video, String? caption}) async {
    emit(HomeLoading());
    try {
      final response =
          await homeRepo.createVideoPost(videoFile: video, caption: caption);
      if (response.statusCode == 201) {
        emit(HomePostCreated());
        fetchPosts();
      } else {
        final body = jsonDecode(await response.stream.bytesToString());
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("create audio post $e");
    }
  }
}
