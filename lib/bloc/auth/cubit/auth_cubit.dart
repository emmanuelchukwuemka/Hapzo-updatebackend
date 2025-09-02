import 'dart:convert';
import 'dart:developer';

import 'package:haptext_api/exports.dart';
import 'package:haptext_api/models/user_infor_model.dart';
import 'package:haptext_api/network/api_constants.dart';
import 'package:haptext_api/repository/auth_repo/auth_repo.dart';
import 'package:haptext_api/repository/profile_repo/profile_repo.dart';
import 'package:haptext_api/utils/session_manager.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial()) {
    fetchUserProfile();
  }
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

      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        emit(AuthRegisterState());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
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

      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(AuthEmailVerifiedState());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(AuthErrorState());
      }
    } catch (e) {
      emit(AuthErrorState());
      log("verify otp $e");
    }
  }

  verifyEmailRequest() async {
    emit(AuthLoadingState());
    try {
      final response =
          await authRepo.requestEmailVerify(email: emailController.text);

      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(AuthVerifyOtpSentState());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(AuthErrorState());
      }
    } catch (e) {
      emit(AuthErrorState());
      log("request verify otp $e");
    }
  }

  UserInfoModel useInfo = UserInfoModel();
  loginUser() async {
    emit(AuthLoadingState());
    try {
      final response = await authRepo.userLogin(
          password: passwordController.text, email: emailController.text);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log("message${body['data']}");
        useInfo = UserInfoModel.fromJson(body["data"]);
        bearerToken = useInfo.tokens?.auth ?? '';
        SessionManager.storeUser(useInfo);
        SessionManager().storeToken(bearerToken);
        emit(AuthLoginState());
      } else {
        if (body["errors"]["detail"].toString().contains("is not verified")) {
          verifyEmailRequest();
        } else {
          ToastMessage.showErrorToast(
              message: body["errors"]["detail"].toString());
          emit(AuthErrorState());
        }
      }
    } catch (e) {
      emit(AuthErrorState());
      log("Login $e");
    }
  }

  requestPasswordReset() async {
    emit(AuthLoadingState());
    try {
      final response =
          await authRepo.requestPasswordReset(email: emailController.text);

      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ToastMessage.showSuccessToast(message: body["message"]);
        emit(AuthResetPasswordOtpState());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
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

      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(AuthResetPasswordSucess());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(AuthErrorState());
      }
    } catch (e) {
      emit(AuthErrorState());
      log("confirm reset Password $e");
    }
  }

  fetchUserProfile() async {
    emit(AuthLoadingState());
    try {
      final response = await ProfileRepo().fetchUserProfile();
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        useInfo = UserInfoModel.fromJson(body["data"]);
        bearerToken = useInfo.tokens?.auth ?? '';
        SessionManager.storeUser(useInfo);
        SessionManager().storeToken(bearerToken);
        emit(AuthLoadedState());
      } else {
        final body = jsonDecode(response.body);
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(AuthErrorState());
      }
    } catch (e) {
      emit(AuthErrorState());
      log("user Profile $e");
    }
  }
}
