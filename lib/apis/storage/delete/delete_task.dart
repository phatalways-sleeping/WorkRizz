import 'package:task_managing_application/apis/storage/Delete/crud_Delete.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class DeleteTask extends Delete {
  const DeleteTask._() : super();

  static Future<void> deleteTask(String id) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(id).delete();
}
