import 'package:task_managing_application/apis/storage/create/crud_create.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart';

final class CreateTask extends Create {
  const CreateTask._() : super();

  static Future<void> createTask(Task task) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(task.id).set(task.toJson());
}
