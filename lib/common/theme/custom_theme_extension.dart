import 'package:flutter/material.dart';
import 'package:haptext_api/common/coloors.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme {
    return Theme.of(this).extension<CustomThemeExtension>()!;
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  static final lightMode = CustomThemeExtension(
    greyColor: Coloors.greyLight,
    primaryColor: Coloors.orangeLight,
    buttonColor: Coloors.lightButton,
    bgColor: Coloors.lightBackground,
    surfaceColor: Colors.white,
    textColor: Coloors.lightText,
    titleTextColor: Coloors.lightTitleText,
    chatTitleColor: Coloors.lightChatTitleText,
    appBarColor: Coloors.lightAppBar,
    readMessageColor: Coloors.lightReadMessage,
    unreadMessageColor: Coloors.lightUnreadMessage,
    userChatBoxColor: Coloors.lightUserChatBox,
    friendChatBoxColor: Coloors.lightFriendChatBox,
  );

  static final darkMode = CustomThemeExtension(
    greyColor: Coloors.greyDark,
    primaryColor: Coloors.orangeDark,
    buttonColor: Coloors.darkButton,
    bgColor: Coloors.darkBackground,
    surfaceColor: Coloors.surface,
    textColor: Coloors.darkText,
    titleTextColor: Coloors.darkTitleText,
    chatTitleColor: Coloors.darkChatTitleText,
    appBarColor: Coloors.darkAppBar,
    readMessageColor: Coloors.darkReadMessage,
    unreadMessageColor: Coloors.darkUnreadMessage,
    userChatBoxColor: Coloors.darkUserChatBox,
    friendChatBoxColor: Coloors.darkFriendChatBox,
  );

  final Color? greyColor;
  final Color? primaryColor;
  final Color? buttonColor;
  final Color? bgColor;
  final Color? surfaceColor;
  final Color? textColor;
  final Color? titleTextColor;
  final Color? chatTitleColor;
  final Color? appBarColor;
  final Color? readMessageColor;
  final Color? unreadMessageColor;
  final Color? userChatBoxColor;
  final Color? friendChatBoxColor;

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? greyColor,
    Color? primaryColor,
    Color? buttonColor,
    Color? bgColor,
    Color? surfaceColor,
    Color? textColor,
    Color? titleTextColor,
    Color? chatTitleColor,
    Color? appBarColor,
    Color? readMessageColor,
    Color? unreadMessageColor,
    Color? userChatBoxColor,
    Color? friendChatBoxColor,
  }) {
    return CustomThemeExtension(
      greyColor: greyColor ?? this.greyColor,
      primaryColor: primaryColor ?? this.primaryColor,
      buttonColor: buttonColor ?? this.buttonColor,
      bgColor: bgColor ?? this.bgColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      textColor: textColor ?? this.textColor,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      chatTitleColor: chatTitleColor ?? this.chatTitleColor,
      appBarColor: appBarColor ?? this.appBarColor,
      readMessageColor: readMessageColor ?? this.readMessageColor,
      unreadMessageColor: unreadMessageColor ?? this.unreadMessageColor,
      userChatBoxColor: userChatBoxColor ?? this.userChatBoxColor,
      friendChatBoxColor: friendChatBoxColor ?? this.friendChatBoxColor,
    );
  }

  const CustomThemeExtension({
    this.greyColor,
    this.primaryColor,
    this.buttonColor,
    this.bgColor,
    this.surfaceColor,
    this.textColor,
    this.titleTextColor,
    this.chatTitleColor,
    this.appBarColor,
    this.readMessageColor,
    this.unreadMessageColor,
    this.userChatBoxColor,
    this.friendChatBoxColor,
  });

  @override
  ThemeExtension<CustomThemeExtension> lerp(
      covariant ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
      bgColor: Color.lerp(bgColor, other.bgColor, t),
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      titleTextColor: Color.lerp(titleTextColor, other.titleTextColor, t),
      chatTitleColor: Color.lerp(chatTitleColor, other.chatTitleColor, t),
      appBarColor: Color.lerp(appBarColor, other.appBarColor, t),
      readMessageColor: Color.lerp(readMessageColor, other.readMessageColor, t),
      unreadMessageColor:
          Color.lerp(unreadMessageColor, other.unreadMessageColor, t),
      userChatBoxColor: Color.lerp(userChatBoxColor, other.userChatBoxColor, t),
      friendChatBoxColor:
          Color.lerp(friendChatBoxColor, other.friendChatBoxColor, t),
    );
  }
}
