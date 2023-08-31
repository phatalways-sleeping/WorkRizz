import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';

import 'crud_create.dart';

final class CreateUserActivity extends Create {
  const CreateUserActivity._() : super();

  static Future<void> createUserActivity(UserActivityModel userActivityModel) =>
      FirebaseFirestoreConfigs.userActivitiesCollection
          .doc(userActivityModel.id)
          .set(userActivityModel.toJson());
}
