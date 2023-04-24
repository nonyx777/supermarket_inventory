import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageNotifier with ChangeNotifier {
  String _selectedLanguage = 'en';

  String get selectedLanguage => _selectedLanguage;

  Future<void> setSelectedLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    _selectedLanguage = language;
    notifyListeners();
  }

  Future<void> loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedLanguage = prefs.getString('language') ?? 'en';
    notifyListeners();
  }
}

