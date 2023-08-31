import 'package:task_managing_application/apis/storage/Delete/crud_Delete.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class DeleteProject extends Delete {
  const DeleteProject._() : super();

  static Future<void> deleteProject(String id) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).delete();
}
