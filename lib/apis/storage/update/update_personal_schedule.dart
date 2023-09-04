import 'package:task_managing_application/apis/storage/update/crud_update.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/personal_schedule/time_line/time_line_model.dart';

final class UpdatePersonalSchedule extends Update {
  const UpdatePersonalSchedule._() : super();

  static Future<void> updateStatus(String id, TimelineStatus status) =>
      FirebaseFirestoreConfigs.personalScheduleCollection.doc(id).update({
        "schedule.status": status == TimelineStatus.day ? "day" : "night",
      });

  static Future<void> updateTimeline(String id, TimelineModel timelineModel) =>
      FirebaseFirestoreConfigs.personalScheduleCollection.doc(id).update({
        "schedule": timelineModel.toJson(),
      });
}
