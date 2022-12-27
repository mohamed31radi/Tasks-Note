

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/shared/network/local/firebase_utils.dart';


class TaskDone extends ChangeNotifier{

  void onPressedDone(TaskData task){
    getTaskCollection().doc(task.id).update({
      'isDone':!task.isDone,
    });
    notifyListeners();
  }
  void updateTaskContent(TaskData task){
    updateTask(task);
    notifyListeners();
  }
}