import 'package:flutter/material.dart';

class ChosenDateProvider extends ChangeNotifier {
  DateTime selectedDate=DateTime.now();
  void changSelectedDate(DateTime chosenDate){
    selectedDate=chosenDate;
    notifyListeners();
  }
}
