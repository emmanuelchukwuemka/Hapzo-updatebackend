import 'package:flutter/material.dart';

class Coloors {
  Coloors._();

  // SocialConnect DESIGN TOKENS
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color primaryStart = Color(0xFF8B5CF6);
  static const Color primaryEnd = Color(0xFF7C3AED);
  static const Color text = Color(0xFFFFFFFF);

  // STATUS COLORS
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color live = Color(0xFFEF4444);

  // LEGACY MAPPING (to avoid breaking existing code during migration)
  static const Color orangeDark = primaryStart;
  static const Color orangeLight = primaryEnd;

  static const Color greyDark = Color(0xFF8696A0);
  static const Color greyLight = Color(0xFF667781);

  static const Color darkBackground = background;
  static Color? lightBackground = Color(0xFFF5F5F5);

  static const Color darkButton = primaryStart;
  static const Color lightButton = primaryEnd;

  static const Color darkAppBar = background;
  static const Color lightAppBar = Color(0xFFFFFFFF);

  static const Color darkText = text;
  static const Color lightText = Color(0xFF000000);

  static const Color darkTitleText = primaryStart;
  static Color? lightTitleText = primaryEnd;

  static const Color darkChatTitleText = greyDark;
  static Color? lightChatTitleText = greyLight;

  static Color? darkReadMessage = primaryStart.withValues(alpha: .65);
  static Color? lightReadMessage = primaryEnd.withValues(alpha: .10);

  static Color darkUnreadMessage = primaryStart.withValues(alpha: .45);
  static const Color lightUnreadMessage = Color(0xFFFFEFEE);

  static Color darkUserChatBox = primaryStart.withValues(alpha: .45);
  static Color lightUserChatBox = primaryStart.withValues(alpha: .15);

  static Color darkFriendChatBox = surface;
  static Color lightFriendChatBox = Color(0xFFEEEEEE);
}

// EXTRA COLORS
// Color(0xFFFFFFDD),
// Color(0xFFFBECB2),
// Color(0xFFF5E8C7),
// Color(0xFFFFEED9),
// Color(0xFFF5EEC8),
