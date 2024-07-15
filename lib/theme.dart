import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tailwind_palette/tailwind_palette.dart';

part 'theme.g.dart';

final backgroundColor = TailwindPalette.slate.shade900;
final surfaceColor = TailwindPalette.slate.shade800;
final textColor = TailwindPalette.slate.shade50;
const accentColors = TailwindPalette.teal;
final accentColor = accentColors.shade300;
final onAccentColor = TailwindPalette.teal.shade900;
final disabledColor = TailwindPalette.slate.shade400;
final errorColor = TailwindPalette.red.shade500;

const elevation = 0.0;
const kBorderRadius = 32.0;

@riverpod
ThemeData theme(ThemeRef ref) {
  return ThemeData(
    datePickerTheme: DatePickerThemeData(
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: backgroundColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: backgroundColor,
      modalBackgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: backgroundColor,
      cardColor: surfaceColor,
      errorColor: errorColor,
      accentColor: accentColor,
      primarySwatch: MaterialColor(
        accentColor.value,
        <int, Color>{
          50: accentColors.shade50,
          100: accentColors.shade100,
          200: accentColors.shade200,
          300: accentColors.shade300,
          400: accentColors.shade400,
          500: accentColors.shade500,
          600: accentColors.shade600,
          700: accentColors.shade700,
          800: accentColors.shade800,
          900: accentColors.shade900,
        },
      ),
      brightness: Brightness.dark,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(linearMinHeight: 8),
    cardTheme: CardTheme(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      errorStyle: TextStyle(color: errorColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: BorderSide(color: accentColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: BorderSide(color: surfaceColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: BorderSide(color: errorColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
        backgroundColor: MaterialStateProperty.all(accentColor),
        foregroundColor: MaterialStateProperty.all(onAccentColor),
        overlayColor: MaterialStateProperty.all(accentColors.shade600),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
    ),
    textTheme: GoogleFonts.b612TextTheme().apply(
      bodyColor: textColor,
      displayColor: textColor,
    ),
  );
}
