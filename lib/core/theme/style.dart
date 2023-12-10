import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_shader/core/theme/index.dart';

class Style {
  static const PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColor,
    primaryColor: ThemeColors.primaryColor,
    appBarTheme: const AppBarTheme(
      elevation: 2,
      color: ThemeColors.appBarColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: ThemeColors.appBarTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      toolbarHeight: 80,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: ThemeColors.bottomNavigationBarBackgroundColor,
      selectedItemColor: ThemeColors.selectedItemColor,
      unselectedItemColor: ThemeColors.unselectedItemColor,
      selectedIconTheme: IconThemeData(size: 36, opacity: 1, color: ThemeColors.selectedItemColor),
      unselectedIconTheme: IconThemeData(size: 32, opacity: 1, color: ThemeColors.unselectedItemColor),
      selectedLabelStyle: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
      unselectedLabelStyle: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
      type: BottomNavigationBarType.fixed,
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      accentColor: ThemeColors.secondaryColor,
      errorColor: ThemeColors.errorColor,
      backgroundColor: ThemeColors.backgroundColor,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme.copyWith(
            displayLarge: ThemeData.light().textTheme.displayLarge?.copyWith(letterSpacing: 0),
            displayMedium: ThemeData.light().textTheme.displayMedium?.copyWith(letterSpacing: 0),
            displaySmall: ThemeData.light().textTheme.displaySmall?.copyWith(letterSpacing: 0),
            headlineMedium: ThemeData.light().textTheme.headlineMedium?.copyWith(letterSpacing: 0),
            headlineSmall: ThemeData.light().textTheme.headlineSmall?.copyWith(letterSpacing: 0),
            titleLarge: ThemeData.light().textTheme.titleLarge?.copyWith(letterSpacing: 0),
            titleMedium: ThemeData.light().textTheme.titleMedium?.copyWith(
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
            titleSmall: ThemeData.light().textTheme.titleSmall?.copyWith(letterSpacing: 0),
            bodyLarge: ThemeData.light().textTheme.bodyLarge?.copyWith(letterSpacing: 0),
            bodyMedium: ThemeData.light().textTheme.bodyMedium?.copyWith(letterSpacing: 0),
            labelLarge: ThemeData.light().textTheme.labelLarge?.copyWith(letterSpacing: 0),
            bodySmall: ThemeData.light().textTheme.bodySmall?.copyWith(letterSpacing: 0),
            labelSmall: ThemeData.light().textTheme.labelSmall?.copyWith(letterSpacing: 0),
          ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: ThemeColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static final ThemeData darkTheme = lightTheme; // TODO(hazarbelge): Configure Dark Theme
}
