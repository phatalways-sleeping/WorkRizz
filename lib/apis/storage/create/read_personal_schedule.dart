import 'package:task_managing_application/apis/storage/read/crud_read.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/personal_schedule/personal_schedule_model.dart';

final class ReadPersonalSchedule extends Read {
  const ReadPersonalSchedule._() : super();

  static Stream<PersonalScheduleModel> personalScheduleStreamById(String id) =>
      FirebaseFirestoreConfigs.personalScheduleCollection
          .doc(id)
          .snapshots()
          .map((event) => PersonalScheduleModel.fromJson(
              event.data() as Map<String, dynamic>));

  static Future<DateTime> dateSchedule(String id) => FirebaseFirestoreConfigs
      .personalScheduleCollection
      .doc(id)
      .get()
      .then((value) =>
          PersonalScheduleModel.fromJson(value as Map<String, dynamic>).date)
      .onError(
        (error, stackTrace) => Future.error("Error has happened!"),
      );
}
