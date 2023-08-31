import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/assets/models/message/message_data.dart';
import 'package:task_managing_application/assets/models/personal_schedule/person_schedule_data.dart';
import 'package:task_managing_application/assets/models/project/project_data.dart';
import 'package:task_managing_application/assets/models/task/task_data.dart';
import 'package:task_managing_application/assets/models/thread/thread_data.dart';
import 'package:task_managing_application/assets/models/user_data/user_activity_data.dart';
import 'package:task_managing_application/assets/models/user_data/user_data.dart';
import 'package:task_managing_application/firebase_options.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:uuid/v8.dart';

import 'sub_task/sub_task_data.dart';

const String path = 'lib/assets/models/';
Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  for (var user in userDataList) {
    await FirebaseFirestoreConfigs.usersCollection
        .doc(user.id)
        .set(user.toJson());
  }

  for (var userActivity in userActivityList) {
    await FirebaseFirestoreConfigs.userActivitiesCollection
        .doc(userActivity.id)
        .set(userActivity.toJson());
  }

  for (var thread in threadList) {
    await FirebaseFirestoreConfigs.projectThreadsCollection
        .doc(thread.id)
        .set(thread.toJson());
  }

  for (var message in messageList) {
    if (message is TextMessageModel) {
      await FirebaseFirestoreConfigs.messagesCollection
          .doc(message.id)
          .set(message.toJson());
    } else if (message is ImageMessageModel) {
      if (message is TextMessageModel) {
        await FirebaseFirestoreConfigs.messagesCollection
            .doc(message.id)
            .set(message.toJson());
      }
    } else if (message is FileMessageModel) {
      if (message is TextMessageModel) {
        await FirebaseFirestoreConfigs.messagesCollection
            .doc(message.id)
            .set(message.toJson());
      }
    }
  }

  for (var task in taskList) {
    await FirebaseFirestoreConfigs.tasksCollection
        .doc(task.id)
        .set(task.toJson());
  }

  for (var subTask in subTaskList) {
    await FirebaseFirestoreConfigs.subTasksCollection
        .doc(subTask.id)
        .set(subTask.toJson());
  }

  for (var project in projectList) {
    await FirebaseFirestoreConfigs.projectsCollection
        .doc(project.id)
        .set(project.toJson());
  }

  for (var schedule in scheduleList) {
    await FirebaseFirestoreConfigs.personalScheduleCollection
        .doc(schedule.id)
        .set(schedule.toJson());
  }
}

Future<void> generateIds({
  required int amount,
  required String name,
}) async {
  final ids = List.generate(
    amount,
    (index) => const UuidV8().generate(),
  );

  final File newFile = File("$path/$name/${name}_ids.txt");

  for (var element in ids) {
    await newFile.writeAsString('$element\n', mode: FileMode.append);
  }
}
