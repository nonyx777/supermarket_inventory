import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme {
  light,
  dark,
  system,
}
class ThemeNotifier with ChangeNotifier {
  AppTheme _selectedTheme = AppTheme.system;

  AppTheme get selectedTheme => _selectedTheme;

  Future<void> setSelectedTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', theme.index);
    _selectedTheme = theme;
    notifyListeners();
  }

  Future<void> loadSelectedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme') ?? AppTheme.system.index;
    _selectedTheme = AppTheme.values[themeIndex];
    notifyListeners();
  }

  ThemeData getThemeData(BuildContext context) {
    switch (selectedTheme) {
      case AppTheme.light:
        return ThemeData.light();
      case AppTheme.dark:
        return ThemeData.dark();
      case AppTheme.system:
      default:
        final brightness = MediaQuery.of(context).platformBrightness;
        if (brightness == Brightness.dark) {
          return ThemeData.dark();
        } else {
          return ThemeData.light();
        }
    }
  }
}
