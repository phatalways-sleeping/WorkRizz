import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_managing_application/apis/storage/update/crud_update.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class UpdateThread extends Update {
  const UpdateThread._() : super();

  static Future<void> updateMessages(String id, List<String> latestVersion) =>
      FirebaseFirestoreConfigs.projectThreadsCollection.doc(id).update({
        "messages": FieldValue.arrayUnion(latestVersion),
      });

  static Future<void> removeMessages(String id, List<String> removedItems) =>
      FirebaseFirestoreConfigs.projectThreadsCollection.doc(id).update({
        "messages": FieldValue.arrayRemove(removedItems),
      });
}
