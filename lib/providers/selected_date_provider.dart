

import 'package:flutter/foundation.dart';

class SelectedDate extends ChangeNotifier{

  DateTime currentDate=DateTime.now();
void changCurrentDate(DateTime date){
  currentDate=date;
  notifyListeners();
}
}