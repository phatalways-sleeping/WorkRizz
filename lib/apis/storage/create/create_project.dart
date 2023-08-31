import 'package:task_managing_application/apis/storage/create/crud_create.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart' show Project;

final class CreateProject extends Create {
  const CreateProject._() : super();

  static Future<void> createNewProject(Project project) =>
      FirebaseFirestoreConfigs.projectsCollection
          .doc(project.id)
          .set(project.toJson());
}
