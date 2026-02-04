import 'package:flutter/material.dart';
import 'custom_theme_extension.dart';
import 'package:haptext_api/common/coloors.dart';

import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    primaryColor: Coloors.primaryEnd,
    textTheme: GoogleFonts.robotoTextTheme(base.textTheme),
    extensions: [
      CustomThemeExtension.lightMode,
    ],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.white,
        backgroundColor: Coloors.primaryEnd,
        splashFactory: NoSplash.splashFactory,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(double.infinity, 50),
      ),
    ),
  );
}
