import 'package:task_managing_application/apis/storage/create/crud_create.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart';

final class CreateSubTask extends Create {
  const CreateSubTask._() : super();

  static Future<void> createSubTask(SubTaskModel subTaskModel) =>
      FirebaseFirestoreConfigs.subTasksCollection
          .doc(subTaskModel.id)
          .set(subTaskModel.toJson());
}
