import 'package:flutter/material.dart';
import 'package:onboarding/common/appbar_theme.dart';
import 'package:onboarding/common/bottom_sheet_theme.dart';
import 'package:onboarding/common/checkbox_theme.dart';
import 'package:onboarding/common/chip_theme.dart';
import 'package:onboarding/common/elevated_button_theme.dart';
import 'package:onboarding/common/outlined_button_theme.dart';
import 'package:onboarding/common/text_field_theme.dart';
import 'package:onboarding/common/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    chipTheme: TChipTheme.LightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppBarTheme.LightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.LightBottomSheetTheme,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOuttinedButtonTheme.LightOuttinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightlnputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOuttinedButtonTheme.darkOuttinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darklnputDecorationTheme,
  );
}
