import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

import 'crud_update.dart';

final class UpdateUserActivity extends Update {
  const UpdateUserActivity._() : super();

  static Future<void> updateUserActivity(
          String id, bool isActive, DateTime lastActive) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).update({
        "isActive": isActive,
        "lastActive": lastActive.toIso8601String(),
      });
}
