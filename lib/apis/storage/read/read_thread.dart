import 'package:task_managing_application/apis/storage/read/crud_read.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart' show ThreadModel;

final class ReadThread extends Read {
  const ReadThread._() : super();

  static Stream<ThreadModel> threadStreamById(String id) =>
      FirebaseFirestoreConfigs.projectThreadsCollection
          .doc(id)
          .snapshots()
          .map((event) => ThreadModel.fromJson(
              event.data() as Map<String, dynamic>));
}
