enum RouteName {
  login('/'),
  signUp('/sign_up'),
  otpScreen('/otp_screen'),
  bottomNav('/bottom_nav'),
  resetPasswordPage('/reset_password_page'),
  resetPaswordSuccess('/reset_password_success'),
  resetPasswordOtpPage('/logic_ninja_menu'),
  forgetPassword('/forget_password'),
  arView('/ar_view'),
  productDetail('/produt_detail');

  final String path;

  const RouteName(this.path);
}
