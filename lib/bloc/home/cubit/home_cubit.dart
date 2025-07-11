import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/repository/home_repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial());

  int page = 0;
  fetchPosts() async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.fetchPost(page: page);

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
      log("register $e");
    }
  }
  createPost() async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.createPost();

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
      log("register $e");
    }
  }
}
