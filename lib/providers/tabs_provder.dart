import 'package:flutter/material.dart';

class TabsProvider extends ChangeNotifier{
  int currentIndex=0;
  void changTab(index){
    currentIndex=index;
    notifyListeners();
  }
}