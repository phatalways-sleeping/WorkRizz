import 'package:task_managing_application/apis/storage/read/crud_read.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart';

final class ReadTask extends Read {
  const ReadTask._() : super();

  static Future<String> taskName(String id) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(id).get().then(
          (value) => Task.fromJson(value.data() as Map<String, dynamic>).name).onError(
            (error, stackTrace) => Future.error("Error has happened!"),
          );

  static Future<String> projectIdBelongTo(String id) =>
      FirebaseFirestoreConfigs.tasksCollection.doc(id).get().then((value) =>
          Task.fromJson(value.data() as Map<String, dynamic>).project).onError(
            (error, stackTrace) => Future.error("Error has happened!"),
          );

  static Stream<Task> taskStreamById(String id) =>
      FirebaseFirestoreConfigs.tasksCollection
          .doc(id)
          .snapshots()
          .map((event) => Task.fromJson(event.data() as Map<String, dynamic>));

}
