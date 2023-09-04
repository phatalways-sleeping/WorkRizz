import 'package:task_managing_application/apis/storage/delete/crud_delete.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class DeleteProjectInvitation extends Delete {
  const DeleteProjectInvitation._() : super();

  static Future<void> deleteProjectInvitation(String id) =>
      FirebaseFirestoreConfigs.projectInvitationsCollection
          .doc(id)
          .delete();
}