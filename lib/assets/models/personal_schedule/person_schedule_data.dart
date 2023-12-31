import 'package:task_managing_application/assets/models/personal_schedule/time_line_model.dart';
import 'package:task_managing_application/models/personal_schedule/personal_schedule_model.dart';

final schedule1 = PersonalScheduleModel(
  id: '20230831-0518-8125-a912-e3d7d81fee82',
  date: DateTime(2023, 9, 1),
  schedule: timeline1,
);

final schedule2 = PersonalScheduleModel(
  id: '20230831-0518-8725-8922-9e9ecda033fe',
  date: DateTime(2023, 9, 2),
  schedule: timeline2,
);

final schedule3 = PersonalScheduleModel(
  id: '20230831-0518-8825-9922-2669e5bb1d1d',
  date: DateTime(2023, 9, 1),
  schedule: timeline3,
);

final schedule4 = PersonalScheduleModel(
  id: '20230831-0518-8425-b922-14b4375c2bb5',
  date: DateTime(2023, 9, 2),
  schedule: timeline4,
);

final schedule5 = PersonalScheduleModel(
  id: '20230831-0518-8e25-b923-a3d16941e901',
  date: DateTime(2023, 9, 3),
  schedule: timeline5,
);

final scheduleList = [
  schedule1,
  schedule2,
  schedule3,
  schedule4,
  schedule5,
];
