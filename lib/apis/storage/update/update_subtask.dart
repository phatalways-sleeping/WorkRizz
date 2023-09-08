import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_managing_application/apis/storage/update/crud_update.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/file/file_model.dart';
import 'package:task_managing_application/models/models.dart';

final class UpdateSubTask extends Update {
  const UpdateSubTask._() : super();

  static Future<void> updateAssignee(String id, String assignee) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "assignee": assignee,
      });

  static Future<void> updateDescription(String id, String description) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "description": description,
      });

  static Future<void> updateGrade(String id, int grade) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "grade": grade,
      });

  static Future<void> updateIsCompleted(String id, bool isCompleted) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "isCompleted": isCompleted,
      });

  static Future<void> updateLeaderComment(String id, String leaderComment) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "leaderComment": leaderComment,
      });

  static Future<void> updateName(String id, String name) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "name": name,
      });

  static Future<void> updatePoints(String id, int points) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "points": points,
      });

  static Future<void> updateProgress(String id, double progress) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "progress": progress,
      });

  static Future<void> updateDueDate(String id, DateTime dueDate) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "dueDate": dueDate.toIso8601String(),
      });

  static Future<void> updateComments(String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "comments": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> removeComments(String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "comments": FieldValue.arrayRemove(removedItems),
      });

  static Future<void> updateFiles(String id, List<FileModel> latestVersion) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "files": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> removeFiles(String id, List<FileModel> removedItems) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).update({
        "files": FieldValue.arrayRemove(removedItems),
      });

  static Future<void> updateSubTask(String id, SubTaskModel subTaskModel) =>
      FirebaseFirestoreConfigs.subTasksCollection
          .doc(id)
          .update(subTaskModel.toJson());
}
