import 'package:task_managing_application/apis/storage/read/crud_read.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart' show Project;

final class ReadProject extends Read {
  const ReadProject._() : super();

  static Stream<Project> projectStream(String id) =>
      FirebaseFirestoreConfigs.projectsCollection.doc(id).snapshots().map(
            (event) => Project.fromJson(
              event.data() as Map<String, dynamic>,
            ),
          );

}
