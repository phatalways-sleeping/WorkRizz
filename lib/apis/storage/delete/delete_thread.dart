import 'package:task_managing_application/apis/storage/delete/crud_delete.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class DeleteThread extends Delete {
  const DeleteThread._() : super();

  static Future<void> deleteThread(String id) =>
      FirebaseFirestoreConfigs.projectThreadsCollection
          .doc(id)
          .delete();
}
