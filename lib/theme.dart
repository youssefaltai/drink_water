import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailwind_palette/tailwind_palette.dart';

final primaryColor = TailwindPalette.slate.shade900;
final lightPrimaryColor = TailwindPalette.slate.shade800;
final onPrimaryColor = TailwindPalette.slate.shade50;
final secondaryColor = TailwindPalette.slate.shade50;
final onSecondaryColor = TailwindPalette.slate.shade900;
final accentColor = TailwindPalette.teal.shade300;
final onAccentColor = TailwindPalette.teal.shade900;
final disabledColor = TailwindPalette.slate.shade400;

final theme = ThemeData(
  disabledColor: disabledColor,
  textTheme: GoogleFonts.b612TextTheme().apply(
    bodyColor: onPrimaryColor,
    displayColor: onPrimaryColor,
  ),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: primaryColor,
  hintColor: disabledColor,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: disabledColor),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: lightPrimaryColor,
    hintStyle: TextStyle(color: disabledColor),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide.none,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    linearTrackColor: onAccentColor,
    color: accentColor,
    linearMinHeight: 8,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(lightPrimaryColor),
      foregroundColor: MaterialStateProperty.all(onPrimaryColor),
      surfaceTintColor: MaterialStateProperty.all(onPrimaryColor),
    ),
  ),
  listTileTheme: ListTileThemeData(
    tileColor: lightPrimaryColor,
    textColor: onPrimaryColor,
    iconColor: onPrimaryColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
  ),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
    dialHandColor: onAccentColor,
    hourMinuteColor: lightPrimaryColor,
    dayPeriodColor: lightPrimaryColor,
    dayPeriodTextColor: accentColor,
    hourMinuteTextColor: accentColor,
    dialBackgroundColor: lightPrimaryColor,
    dialTextColor: accentColor,
    entryModeIconColor: accentColor,
    cancelButtonStyle: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(lightPrimaryColor),
      foregroundColor: MaterialStateProperty.all(onPrimaryColor),
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(accentColor),
      foregroundColor: MaterialStateProperty.all(onAccentColor),
    ),
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
  ),
  cardTheme: CardTheme(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
    color: lightPrimaryColor,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(accentColor),
      elevation: MaterialStateProperty.all(0),
      foregroundColor: MaterialStateProperty.all(onAccentColor),
      minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
    ),
  ),
);
