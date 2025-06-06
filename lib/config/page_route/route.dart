import 'package:go_router/go_router.dart';
import 'package:haptext_api/config/page_route/route_name.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/main.dart';
import 'package:haptext_api/views/navigation.dart';
import 'package:haptext_api/views/screen/authentication/sign_in.dart';
import 'package:haptext_api/views/screen/authentication/sign_up.dart';

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
      // GoRoute(
      //     path: RouteName.blitzSuccessScreen.path,
      //     builder: (context, state) {
      //       return BlitzSuccessPage();
      //     }),

      // /////////////////////////
      // ///mini games navigation//
      // /////////////////////////
      // GoRoute(
      //     path: RouteName.miniGamesHome.path,
      //     builder: (context, state) {
      //       return MiniGamesHomePage();
      //     }),
      // GoRoute(
      //     path: RouteName.logicNinjaMenu.path,
      //     builder: (context, state) {
      //       return LogicNinjaMenu();
      //     }),
      // GoRoute(
      //     path: RouteName.addProduct.path,
      //     builder: (context, state) {
      //       return AddProduct();
      //     }),
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
