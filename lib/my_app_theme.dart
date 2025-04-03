import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/app_colors.dart';

final ThemeData MyAppTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.lightBackgroundColor,
  primaryColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(
    color: AppColors.primaryColor,
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    selectedIconTheme: IconThemeData(
      color: AppColors.primaryColor,
    ),
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.greyColor,
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.poppins(
      color: AppColors.whiteColor,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: GoogleFonts.poppins(
      color: AppColors.primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  ),
);
