import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

import 'crud_delete.dart';

final class DeleteUserActivity extends Delete {
  const DeleteUserActivity._() : super();

  static Future<void> deleteUserActivity(String id) =>
      FirebaseFirestoreConfigs.userActivitiesCollection
          .doc(id)
          .delete();
}
