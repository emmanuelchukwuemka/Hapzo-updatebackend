import 'dart:convert';
import 'dart:developer';

import 'package:haptext_api/exports.dart';
import 'package:haptext_api/repository/home_repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial());

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

  createPost({String? postFormat, String? textContent}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.createPost(
          postFormat: postFormat ?? '', textContent: textContent ?? "");
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
      log("register $e");
    }
  }
}
