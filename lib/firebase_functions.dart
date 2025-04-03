import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance.collection('Tasks').withConverter(
      fromFirestore: (snapshot, options) {
        return Task.fromJson(snapshot.data()!);
      },
      toFirestore: (task, options) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTask(Task task) {
    var Collection = getTaskCollection();
    var docRef = Collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<Task>> getTask(DateTime date) {
    var collection = getTaskCollection();
    return collection
        .where("dateTime",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String taskId){
    var collection = getTaskCollection();
    return collection.doc(taskId).delete();
  }

  static Future<void> updateTask(Task task){
    var collection = getTaskCollection();
    return collection.doc(task.id).update(task.toJson());
  }
}
