import 'package:task_managing_application/apis/storage/Delete/crud_Delete.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class DeleteSubTask extends Delete {
  const DeleteSubTask._() : super();

  static Future<void> deleteSubTask(String id) =>
      FirebaseFirestoreConfigs.subTasksCollection
          .doc(id)
          .delete();
}
