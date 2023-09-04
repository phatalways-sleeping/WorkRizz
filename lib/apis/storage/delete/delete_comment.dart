import 'package:task_managing_application/apis/storage/delete/crud_delete.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class DeleteComment extends Delete {
  const DeleteComment._() : super();

  static Future<void> deleteComment(String id) =>
      FirebaseFirestoreConfigs.subTaskCommentsCollection.doc(id).delete();
}
