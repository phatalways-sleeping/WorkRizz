import 'package:task_managing_application/apis/storage/read/crud_read.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart';

final class ReadSubTask extends Read {
  const ReadSubTask._() : super();

  static Future<String> assigneeOfSubTask(String id) => FirebaseFirestoreConfigs
      .subTasksCollection
      .doc(id)
      .get()
      .then((value) =>
          SubTaskModel.fromJson(value.data() as Map<String, dynamic>).assignee)
      .onError(
        (error, stackTrace) => Future.error("Error has happened!"),
      );

  static Future<String> nameOfSubTask(String id) =>
      FirebaseFirestoreConfigs.subTasksCollection
          .doc(id)
          .get()
          .then((value) =>
              SubTaskModel.fromJson(value.data() as Map<String, dynamic>).name)
          .onError(
            (error, stackTrace) => Future.error("Error has happened!"),
          );

  static Stream<SubTaskModel> subTaskModelStreamById(String id) =>
      FirebaseFirestoreConfigs.subTasksCollection.doc(id).snapshots().map(
          (event) =>
              SubTaskModel.fromJson(event.data()! as Map<String, dynamic>));
}
