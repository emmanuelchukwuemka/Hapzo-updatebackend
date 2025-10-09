import 'package:haptext_api/exports.dart';
import 'package:haptext_api/main.dart';
import 'package:haptext_api/models/searched_user_model.dart';
import 'package:haptext_api/views/Bottom_Nav/People/friend_profile_page.dart';
import 'package:haptext_api/views/Bottom_Nav/Post/upload_photo_post.dart';
import 'package:haptext_api/views/Bottom_Nav/Post/post_video_upload.dart';
import 'package:haptext_api/views/Bottom_Nav/Post/post_audio_upload_page.dart';
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
          path: RouteName.createPhotoPost.path,
          builder: (context, state) {
            return const CreatePhotoPost();
          }),
      GoRoute(
          path: RouteName.confirmVideoUpload.path,
          builder: (context, state) {
            return const PostVideoUpload();
          }),
      GoRoute(
          path: RouteName.editProfile.path,
          builder: (context, state) {
            return const EditProfile();
          }),
      GoRoute(
          path: RouteName.friendsProfilePage.path,
          builder: (context, state) {
            final SearchedUserModel user = state.extra as SearchedUserModel;
            return FriendProfilePage(user: user);
          }),
    ],
  );
}
