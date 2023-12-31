import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_managing_application/apis/storage/update/crud_update.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart';

final class UpdateTask extends Update {
  const UpdateTask._() : super();

  static Future<void> updateName(String id, String name) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(id).update({
        "name": name,
      });

  static Future<void> updateIsCompleted(String id, bool isCompleted) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(id).update({
        "isCompleted": isCompleted,
      });

  static Future<void> updatePoints(String id, int increase) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(id).update({
        "points": FieldValue.increment(increase),
      });

  static Future<void> updateSubTasks(String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(id).update({
        "subTasks": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> removeSubTasks(String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(id).update({
        "subTasks": FieldValue.arrayRemove(removedItems),
      });

  static Future<void> updateTask(String id, Task task) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(id).update(task.toJson());

  static Future<void> updateSubTasksCompleted(
          String id, int increase) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(id).update({
        "subTasksCompleted": FieldValue.increment(increase),
      });
}
