import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart' show ThreadModel;

import 'crud_create.dart';

final class CreateThread extends Create {
  const CreateThread._() : super();

  static Future<void> createNewThread(ThreadModel threadModel) =>
      FirebaseFirestoreConfigs.projectThreadsCollection
          .doc(threadModel.id)
          .set(threadModel.toJson());
}
