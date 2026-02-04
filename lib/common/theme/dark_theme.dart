import 'package:flutter/material.dart';
import 'custom_theme_extension.dart';
import 'package:haptext_api/common/coloors.dart';

import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    scaffoldBackgroundColor: Coloors.background,
    primaryColor: Coloors.primaryStart,
    textTheme: GoogleFonts.robotoTextTheme(base.textTheme),
    extensions: [
      CustomThemeExtension.darkMode,
    ],
    appBarTheme: AppBarTheme(
      backgroundColor: Coloors.background,
      elevation: 0,
      titleTextStyle: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Coloors.primaryStart,
        foregroundColor: Colors.white,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(double.infinity, 50),
      ),
    ),
  );
}
