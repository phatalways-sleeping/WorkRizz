import 'package:task_managing_application/apis/storage/delete/crud_delete.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class DeletePersonalSchedule extends Delete {
  const DeletePersonalSchedule._() : super();

  static Future<void> deletePersonalSchedule(
          String id) =>
      FirebaseFirestoreConfigs.personalScheduleCollection
          .doc(id)
          .delete();
}
