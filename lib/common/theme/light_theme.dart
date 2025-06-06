import 'package:flutter/material.dart';
import 'custom_theme_extension.dart';
import 'package:haptext_api/common/coloors.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor:  Coloors.lightBackground,
    scaffoldBackgroundColor: Coloors.lightBackground,
    extensions: [
      CustomThemeExtension.lightMode,
    ],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        shadowColor: Colors.transparent,
        foregroundColor: Coloors.lightBackground,
        backgroundColor: Coloors.orangeLight,
        splashFactory: NoSplash.splashFactory,
        minimumSize: const Size(double.infinity, 50),
      ),
    ),  
  );
}