import 'package:flutter/material.dart';

class Coloors {
  Coloors._();

  static const Color orangeDark = Color(0xFFFD6104);
  static const Color orangeLight = Color(0xFFFD8502);

  static const Color greyDark = Color(0xFF8696A0);
  static const Color greyLight = Color(0xFF667781);

  static Color? darkBackground = Colors.blueGrey[900];
  static Color? lightBackground = Colors.grey[200];

  static const Color darkButton = Color(0xFFFD6104);
  static const Color lightButton = Color(0xFFFD8502);

  static const Color darkAppBar = Color(0xFF111B21);
  static const Color lightAppBar = Color(0xFFFFFFFF);

  static const Color darkText = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF000000);

  static const Color darkTitleText = Color(0xFFFD6104);
  static Color? lightTitleText = const Color(0xFFFD8502);

  static const Color darkChatTitleText = Colors.blueGrey;
  static Color? lightChatTitleText = Colors.blueGrey[300];

  static Color? darkReadMessage = Colors.orange.withValues(alpha: .65);
  static Color? lightReadMessage = Colors.orange.withValues(alpha: .10);

  static Color darkUnreadMessage = Colors.orange.withValues(alpha: .45);
  static const Color lightUnreadMessage = Color(0xFFFFEFEE);

  static Color darkUserChatBox = Colors.orange.withValues(alpha: .45);
  static Color lightUserChatBox = Colors.orange.withValues(alpha: .15);

  static Color darkFriendChatBox = Colors.blueGrey.withValues(alpha: .45);
  static Color lightFriendChatBox = Colors.blueGrey.withValues(alpha: .15);
}

// EXTRA COLORS
// Color(0xFFFFFFDD),
// Color(0xFFFBECB2),
// Color(0xFFF5E8C7),
// Color(0xFFFFEED9),
// Color(0xFFF5EEC8),
