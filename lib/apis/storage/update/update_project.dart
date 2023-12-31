import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_managing_application/apis/storage/update/crud_update.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart' show Tag;
import 'package:task_managing_application/models/project/files_small_info.dart';
import 'package:task_managing_application/models/project/task_small_info.dart';

final class UpdateProject extends Update {
  const UpdateProject._() : super();

  static Future<void> updateAssignees(String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "assignees": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> removeAssignees(String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "assignees": FieldValue.arrayRemove(removedItems),
      });

  static Future<void> updateAssigneeImageUrls(String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "assigneeImageUrls": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> removeAssigneeImageUrls(String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "assigneeImageUrls": FieldValue.arrayRemove(removedItems),
      });

  static Future<void> updateTasksCompleted(String id, int increase) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "tasksCompleted": FieldValue.increment(increase),
      });

  static Future<void> updateActivitiesCompleted(
          String id, int increase) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "activitiesCompleted": FieldValue.increment(increase),
      });

  static Future<void> updateTotalActivities(String id, int increase) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "totalActivities": FieldValue.increment(increase),
      });

  static Future<void> updateTotalFileLinks(String id, int increase) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "totalFileLinks": FieldValue.increment(increase),
      });

  static Future<void> updateIsCompleted(String id, bool isCompleted) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "isCompleted": isCompleted,
      });

  static Future<void> updateStartDate(String id, DateTime startDate) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "startDate": startDate.toIso8601String(),
      });

  static Future<void> updateEndDate(String id, DateTime endDate) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "endDate": endDate.toIso8601String(),
      });

  static Future<void> updateLeader(String id, String leader) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "leader": leader,
      });

  static Future<void> updateCreatorId(String id, String creatorId) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "creatorId": creatorId,
      });

  static Future<void> updateLeaderImageUrl(String id, String leaderImageUrl) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "leaderImageUrl": leaderImageUrl,
      });

  static Future<void> updateMostActiveMembers(
          String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "mostActiveMemebers": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> removeMostActiveMembers(
          String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "mostActiveMemebers": FieldValue.arrayRemove(removedItems),
      });

  static Future<void> updateName(String id, String name) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "name": name,
      });

  static Future<void> updateTags(String id, List<Tag> latestVersion) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "tags": FieldValue.arrayUnion(
          latestVersion.map((e) => e.toJson()).toList(),
        ),
      });

  static Future<void> removeTags(String id, List<Tag> removedItems) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "tags": FieldValue.arrayRemove(
            removedItems.map((e) => e.toJson()).toList()),
      });

  static Future<void> updateTasks(String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "tasks": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> removeTasks(String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "tasks": FieldValue.arrayRemove(removedItems),
      });

  static Future<void> updateThread(String id, String thread) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "thread": thread,
      });

  static Future<void> updateTaskSmallInformations(String id, List<TaskSmallInformation> latestVersion) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "taskSmallInformations": FieldValue.arrayUnion(
          latestVersion.map((e) => e.toJson()).toList(),
        ),
      });

  static Future<void> removeTaskSmallInformations(String id, List<TaskSmallInformation> removedItems) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "taskSmallInformations": FieldValue.arrayRemove(
            removedItems.map((e) => e.toJson()).toList()),
      });

  static Future<void> updateFileSmallInformations(String id, List<FilesSmallInformation> latestVersion) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "filesSmallInformations": FieldValue.arrayUnion(
          latestVersion.map((e) => e.toJson()).toList(),
        ),
      });
  
  static Future<void> removeFileSmallInformations(String id, List<FilesSmallInformation> removedItems) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).update({
        "filesSmallInformations": FieldValue.arrayRemove(
            removedItems.map((e) => e.toJson()).toList()),
      });
}
