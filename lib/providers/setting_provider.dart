

import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier{
  String language='en';
  ThemeMode thMode=ThemeMode.light;

  void changeLanguage(String lang){
    if(language==lang){
      return;
    }
    language=lang;
    notifyListeners();
  }
  void changeMode(ThemeMode theme){
    thMode=theme;
    notifyListeners();
  }
}