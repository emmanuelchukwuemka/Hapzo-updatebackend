enum RouteName {
  login('/'),
  signUp('/sign_up'),
  otpScreen('/otp_screen'),
  bottomNav('/bottom_nav'),
  resetPasswordPage('/reset_password_page'),
  resetPaswordSuccess('/reset_password_success'),
  resetPasswordOtpPage('/logic_ninja_menu'),
  forgetPassword('/forget_password'),
  createTextPostPage('/create_text_post_page'),
  productDetail('/produt_detail');

  final String path;

  const RouteName(this.path);
}
