enum RouteName {
  splah('/'),
  login('/login'),
  signUp('/sign_up'),
  otpScreen('/otp_screen'),
  bottomNav('/bottom_nav'),
  resetPasswordPage('/reset_password_page'),
  resetPaswordSuccess('/reset_password_success'),
  resetPasswordOtpPage('/logic_ninja_menu'),
  forgetPassword('/forget_password'),
  createTextPostPage('/create_text_post_page'),
  audioUploadPage('/audio_upload_page'),
  createPhotoPost('/create_photo_post'),
  confirmVideoUpload('/confirm_Video_upload'),
  friendsProfilePage('/friend_profile_page'),
  chatPage('/chat_page'),
  commentpage('/comment_page'),
  voiceCallPage('/voice_call_page'),
  videoCallPage('/video_call_page'),
  editProfile('/edit_profile_page');

  final String path;

  const RouteName(this.path);
}
