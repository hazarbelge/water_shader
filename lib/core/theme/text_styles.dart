import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_shader/core/theme/index.dart';

class TextStyles {
  static TextStyle title = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w400).fontFamily,
    fontSize: 34,
    color: Colors.white,
  );

  static TextStyle titleBold = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily,
    fontSize: 34,
    color: Colors.white,
  );

  static TextStyle description = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily,
    fontSize: 16,
    color: Colors.white,
  );

  static TextStyle descriptionBold = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w800).fontFamily,
    fontSize: 16,
    color: Colors.white,
  );

  static TextStyle label = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
    fontSize: 16,
    color: ThemeColors.labelTextColor,
  );

  static TextStyle paragraph = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w500).fontFamily,
    fontSize: 14,
    color: ThemeColors.primaryTextColor,
  );

  static TextStyle paragraphLight = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w400).fontFamily,
    fontSize: 14,
    color: ThemeColors.primaryTextColor,
  );

  static TextStyle paragraphBold = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily,
    fontSize: 14,
    color: ThemeColors.primaryTextColor,
  );

  static TextStyle inputBox = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
    fontSize: 16,
    color: ThemeColors.primaryTextColor,
  );

  static TextStyle inputBoxLabel = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
    fontSize: 16,
    color: ThemeColors.primaryTextColor,
  );

  static TextStyle inputBoxHint = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
    fontSize: 16,
    color: ThemeColors.secondaryTextColor,
  );

  static TextStyle buttonText = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
    fontSize: 16,
    color: ThemeColors.primaryTextColor,
  );
}
