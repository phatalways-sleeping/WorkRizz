import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_managing_application/apis/storage/update/crud_update.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class UpdateUser extends Update {
  const UpdateUser._() : super();

  static Future<void> updateImageUrl(String id, String imageUrl) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "imageUrl": imageUrl,
      });

  static Future<void> updateUsername(String id, String username) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "username": username,
      });

  static Future<void> updateEmail(String id, String email) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "email": email,
      });

  static Future<void> updateProjects(String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "projects": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> updateTasks(String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "tasks": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> updateSubTasks(String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "subTasks": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> updatePersonalSchedule(String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "personalSchedules": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> removeProjects(String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "projects": FieldValue.arrayRemove(removedItems),
      });

  static Future<void> removeTasks(String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "tasks": FieldValue.arrayRemove(removedItems),
      });

  static Future<void> removeSubTasks(String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "subTasks": FieldValue.arrayRemove(removedItems),
      });

  static Future<void> removePersonalSchedule(String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "personalSchedules": FieldValue.arrayRemove(removedItems),
      });
}
