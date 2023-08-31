import 'package:task_managing_application/apis/storage/create/crud_create.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/personal_schedule/personal_schedule_model.dart';

final class CreatePersonalSchedule extends Create {
  const CreatePersonalSchedule._() : super();

  static Future<void> createNewPersonalSchedule(
          PersonalScheduleModel personalScheduleModel) =>
      FirebaseFirestoreConfigs.personalScheduleCollection
          .doc(personalScheduleModel.id)
          .set(personalScheduleModel.toJson());
}
