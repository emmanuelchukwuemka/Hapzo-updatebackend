import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haptext_api/repository/people_repo/people_repo.dart';
import 'package:haptext_api/utils/toast_helper.dart';
import 'package:meta/meta.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleRepo peopleRepo;
  PeopleCubit(this.peopleRepo) : super(PeopleInitial()) {
    fetchFriends();
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
}
