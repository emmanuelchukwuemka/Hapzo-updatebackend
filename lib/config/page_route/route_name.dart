enum RouteName {
  login('/'),
  signUp('/sign_up'),
  otpScreen('/otp_screen'),
  bottomNav('/bottom_nav'),
  blitzSuccessScreen('/blitz_success_screen'),
  //////////////////////////////////////////
  ///Mini Games//////////////////////////
  miniGamesHome('/mini_game_home'),
  logicNinjaMenu('/logic_ninja_menu'),
  addProduct('/add_product'),
  arView('/ar_view'),
  productDetail('/produt_detail');

  final String path;

  const RouteName(this.path);
}
