import 'package:flutter/material.dart';
import 'package:easy_khata/util/theme/_color_scheme.dart';

@immutable
class UdhariTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: Color_Scheme.lightThemeColor,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: Color_Scheme.darkThemeColor,
  );
}