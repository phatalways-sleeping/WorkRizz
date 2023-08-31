import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';

import 'crud_read.dart';

final class ReadUserActivity extends Read {
  const ReadUserActivity._() : super();

  static Stream<UserActivityModel> userActivityStream(String id) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).snapshots().map(
            (event) => UserActivityModel.fromJson(
              event.data() as Map<String, dynamic>,
            ),
          );

  static Stream<bool> onlineStatusOfUserStream(String id) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).snapshots().map(
            (event) => UserActivityModel.fromJson(
              event.data() as Map<String, dynamic>,
            ).isActive,
          );

  static Stream<DateTime> lastActiveOfUserStream(String id) =>
      FirebaseFirestoreConfigs.userActivitiesCollection.doc(id).snapshots().map(
            (event) => UserActivityModel.fromJson(
              event.data() as Map<String, dynamic>,
            ).lastActive,
          );
}
