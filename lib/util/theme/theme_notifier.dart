import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_khata/util/Cosntant.dart';
import 'package:easy_khata/util/shared_pref.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier(): super(ThemeMode.system) {
    _initializeThemeFromSharedPref();
  }

  void _initializeThemeFromSharedPref() {
    final isDarkMode = SharedPrefs.instance.getBool(Constant.kDarkMode) ?? false;
    state = _getThemeMode(isDarkMode);
  }


  void changeTheme(bool isDarkMode) {
    state = _getThemeMode(isDarkMode);
    SharedPrefs.instance.setBool(Constant.kDarkMode, isDarkMode);
  }

  ThemeMode _getThemeMode(bool isDarkMode) {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}