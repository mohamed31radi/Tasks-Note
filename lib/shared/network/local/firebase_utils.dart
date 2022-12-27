
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_data.dart';


CollectionReference<TaskData> getTaskCollection(){
  return FirebaseFirestore.instance.collection('tasks').
  withConverter<TaskData>(
    fromFirestore: (snapshot, options) => TaskData.fromJson(snapshot.data()!),
    toFirestore:(task, options) =>task.toJson() ,
  );
}


Future<void> addTaskToFirebaseFireStore(TaskData taskData){
  var collection=getTaskCollection();
  var docRef=collection.doc();
  taskData.id=docRef.id;
  return docRef.set(taskData);
}


Stream<QuerySnapshot<TaskData>> getTasksFromFirebase(DateTime dateTime){
  return getTaskCollection().where('date',
      isEqualTo: DateUtils.dateOnly(dateTime).microsecondsSinceEpoch).snapshots();
}

Future<void> deleteFromFirebase(String id){
  return getTaskCollection().doc(id).delete();
}

Future<void> updateTask(TaskData task){
  return getTaskCollection().doc(task.id).update(task.toJson());
}