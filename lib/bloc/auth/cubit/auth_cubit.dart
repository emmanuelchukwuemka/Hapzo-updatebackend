import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/models/user_infor_model.dart';
import 'package:haptext_api/network/api_constants.dart';
import 'package:haptext_api/repository/auth_repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final otpController = TextEditingController();

  registerUser() async {
    emit(AuthLoadingState());
    try {
      final response = await authRepo.registerUser(
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          passwordConfirm: passwordConfirmController.text);
      log(response.body);
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        emit(AuthRegisterState());
      } else {
        ToastMessage.showErrorToast(message: body["message"]);
        emit(AuthErrorState());
      }
    } catch (e) {
      emit(AuthErrorState());
      log("register $e");
    }
  }

  verifyEmail() async {
    emit(AuthLoadingState());
    try {
      final response = await authRepo.verifyUserEmail(
          otp: otpController.text, email: emailController.text);
      log(response.body);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(AuthEmailVerifiedState());
      } else {
        ToastMessage.showErrorToast(message: body["error"]);
        emit(AuthErrorState());
      }
    } catch (e) {
      emit(AuthErrorState());
      log("verify otp $e");
    }
  }

  UserInfoModel useInfo = UserInfoModel();
  loginUser() async {
    emit(AuthLoadingState());
    try {
      final response = await authRepo.userLogin(
          password: passwordController.text, email: emailController.text);
      log(response.body);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        useInfo = UserInfoModel.fromJson(body);
        bearerToken = useInfo.token ?? '';
        emit(AuthLoginState());
      } else {
        ToastMessage.showErrorToast(message: body["error"]);
        emit(AuthErrorState());
      }
    } catch (e) {
      emit(AuthErrorState());
      log("verify otp $e");
    }
  }

  requestPasswordReset() async {
    emit(AuthLoadingState());
    try {
      final response =
          await authRepo.requestPasswordReset(email: emailController.text);
      log(response.body);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ToastMessage.showSuccessToast(message: body["message"]);
        emit(AuthResetPasswordOtpState());
      } else {
        ToastMessage.showErrorToast(message: body["message"]);
        emit(AuthErrorState());
      }
    } catch (e) {
      emit(AuthErrorState());
      log("verify otp $e");
    }
  }

  final confirmPasword = TextEditingController();
  resetPassword() async {
    emit(AuthLoadingState());
    try {
      final response = await authRepo.resetPassword(
          newPassword: passwordController.text,
          confirmNewPassword: confirmPasword.text,
          otp: otpController.text,
          email: emailController.text);
      log(response.body);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(AuthResetPasswordSucess());
      } else {
        ToastMessage.showErrorToast(message: body["message"]);
        emit(AuthErrorState());
      }
    } catch (e) {
      emit(AuthErrorState());
      log("confirm reset Password $e");
    }
  }
}
