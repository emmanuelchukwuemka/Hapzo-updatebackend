import 'package:go_router/go_router.dart';
import 'package:haptext_api/config/page_route/route_name.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/main.dart';
import 'package:haptext_api/views/navigation.dart';
import 'package:haptext_api/views/screen/authentication/forget_password.dart';
import 'package:haptext_api/views/screen/authentication/reset_password.dart';
import 'package:haptext_api/views/screen/authentication/reset_password_otp.dart';
import 'package:haptext_api/views/screen/authentication/reset_password_success.dart';

class AppRoute {
  // GoRouter configuration
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
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
      // GoRoute(
      //     path: RouteName.botomNav.path,
      //     builder: (context, state) {
      //       return HomePage();
      //     }),
      // GoRoute(
      //     path: RouteName.productDetail.path,
      //     builder: (context, state) {
      //       final ProductModel product = state.extra as ProductModel;
      //       return ProductDetail(product: product);
      //     }),
    ],
  );
}
