import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/main.dart';
import 'package:haptext_api/views/Bottom_Nav/Post/confirm_image_upload.dart';
import 'package:haptext_api/views/Bottom_Nav/Post/confirm_video_upload.dart';
import 'package:haptext_api/views/Bottom_Nav/Post/new_file_selection/post_audio_upload_page.dart';
import 'package:haptext_api/views/Bottom_Nav/Post/text_write_up.dart';
import 'package:haptext_api/views/Bottom_Nav/Profile/edit_profile.dart';
import 'package:haptext_api/views/navigation.dart';
import 'package:haptext_api/views/screen/authentication/forget_password.dart';
import 'package:haptext_api/views/screen/authentication/reset_password.dart';
import 'package:haptext_api/views/screen/authentication/reset_password_otp.dart';
import 'package:haptext_api/views/screen/authentication/reset_password_success.dart';

class AppRoute {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
          path: RouteName.splah.path,
          builder: (context, state) {
            return const SplashPage();
          }),
      GoRoute(
          path: RouteName.login.path,
          builder: (context, state) {
            return const SignIn();
          }),
      GoRoute(
          path: RouteName.signUp.path,
          builder: (context, state) {
            return const Register();
          }),
      GoRoute(
          path: RouteName.otpScreen.path,
          builder: (context, state) {
            return const OTPVerification();
          }),
      GoRoute(
          path: RouteName.bottomNav.path,
          builder: (context, state) {
            return const Navigation();
          }),
      GoRoute(
          path: RouteName.forgetPassword.path,
          builder: (context, state) {
            return const ForgetPasswordPage();
          }),
      GoRoute(
          path: RouteName.resetPasswordPage.path,
          builder: (context, state) {
            return const ResetPasswordPage();
          }),
      GoRoute(
          path: RouteName.resetPasswordOtpPage.path,
          builder: (context, state) {
            return const ResetPasswordOtpPage();
          }),
      GoRoute(
          path: RouteName.resetPaswordSuccess.path,
          builder: (context, state) {
            return const ResetPasswordSuccessPage();
          }),
      GoRoute(
          path: RouteName.createTextPostPage.path,
          builder: (context, state) {
            return const WriteText();
          }),
      GoRoute(
          path: RouteName.audioUploadPage.path,
          builder: (context, state) {
            return const PostAudioUploadPage();
          }),
      GoRoute(
          path: RouteName.confirmImageUpload.path,
          builder: (context, state) {
            final PlatformFile file = state.extra as PlatformFile;
            return ConfirmImageUpload(pickedFile: file);
          }),
      GoRoute(
          path: RouteName.confirmVideoUpload.path,
          builder: (context, state) {
            final File file = state.extra as File;
            return ConfirmVideoUpload(videoFile: file);
          }),
      GoRoute(
          path: RouteName.editProfile.path,
          builder: (context, state) {
            return const EditProfile();
          }),
    ],
  );
}
