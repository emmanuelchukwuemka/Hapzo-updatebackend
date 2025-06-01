import 'package:flutter/material.dart';
import 'custom_theme_extension.dart';
import 'package:haptext_api/common/coloors.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: Coloors.darkBackground,
    scaffoldBackgroundColor: Coloors.darkBackground,
    primaryColor: Coloors.orangeDark,
    extensions: [
      CustomThemeExtension.darkMode,
    ],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Coloors.orangeDark,
        foregroundColor: Coloors.darkBackground,
        splashFactory: NoSplash.splashFactory,
        elevation: 5.0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 50),
      ),
    ),
  );
}