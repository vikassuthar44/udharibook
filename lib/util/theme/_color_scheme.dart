import 'package:flutter/material.dart';

import '_theme_color.dart';
class Color_Scheme {
  static const lightThemeColor = ColorScheme(
      brightness: Brightness.light,
      primary: ThemeColor.primary,
      onPrimary: ThemeColor.onPrimary,
      secondary: ThemeColor.secondary,
      onSecondary: ThemeColor.onSecondary,
      error: ThemeColor.error,
      onError: ThemeColor.onError,
      background: ThemeColor.background,
      onBackground: ThemeColor.onBackground,
      surface: ThemeColor.surface,
      onSurface: ThemeColor.onSurface);
  static const darkThemeColor = ColorScheme(
      brightness: Brightness.dark,
      primary: ThemeColor.dark_primary,
      onPrimary: ThemeColor.dark_onPrimary,
      secondary: ThemeColor.dark_secondary,
      onSecondary: ThemeColor.dark_onSecondary,
      error: ThemeColor.dark_error,
      onError: ThemeColor.dark_onError,
      background: ThemeColor.dark_background,
      onBackground: ThemeColor.dark_onBackground,
      surface: ThemeColor.dark_surface,
      onSurface: ThemeColor.dark_onSurface
  );
}