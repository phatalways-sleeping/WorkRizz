import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/fonts/text_theme_builder.dart';

mixin LightTheme {
  static const Color primaryColor = Color(0xFF5CD669); // 5CD669
  static const Color accentColor = Color(0xFF9C9AFF); // 9C9AFF
  static const Color backgroundColor = Color(0xFFDDDDDD); // DDDDDD
  static const Color buttonColor = Color(0xFFF6BB54); // F6BB54
  static const Color errorColor = Colors.red;

  static final ThemeData theme = ThemeData(
    textTheme: TextThemeBuilder.robotoTextTheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: buttonColor,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: const ColorScheme(
      primary: primaryColor,
      secondary: accentColor,
      surface: Colors.white,
      background: backgroundColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
  );
}
