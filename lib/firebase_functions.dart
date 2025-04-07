import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/model/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<Task> getTaskCollection(String uid) {
    return getUserCollection().doc(uid).collection('Tasks').withConverter(
      fromFirestore: (snapshot, options) {
        return Task.fromJson(snapshot.data()!);
      },
      toFirestore: (task, options) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTask(Task task, String uid) {
    var Collection = getTaskCollection(uid);
    var docRef = Collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<Task>> getTask(DateTime date, String uid) {
    var collection = getTaskCollection(uid);
    return collection
        .where("dateTime",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String taskId, String uid) {
    var collection = getTaskCollection(uid);
    return collection.doc(taskId).delete();
  }

  static Future<void> updateTask(Task task, String uid) {
    var collection = getTaskCollection(uid);
    return collection.doc(task.id).update(task.toJson());
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) {
        return MyUser.fromFirestore(snapshot.data()!);
      },
      toFirestore: (user, options) {
        return user.toFirestore();
      },
    );
  }

  static Future<void> addUser(MyUser user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFirestore(String uid) async {
    var querySnapshot = await getUserCollection().doc(uid).get();
    return querySnapshot.data();
  }
}
