import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
// import 'package:task_managing_application/firebase_options.dart';
// import 'package:task_managing_application/repositories/application_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_managing_application/apis/storage/crud.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/assets/models/task/task_data.dart';
import 'package:task_managing_application/firebase_options.dart';
import 'package:uuid/v8.dart';

import 'project_invitation/project_invitation_data.dart';

// import 'project/project_data.dart';

const String path = 'lib/assets/models/';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ApplicationRepository.repository.userId =
  //     "20230831-0517-8230-a202-0089f860b83a";

  // for (var user in userDataList) {
  //   await FirebaseFirestoreConfigs.usersCollection
  //       .doc(user.id)
  //       .set(user.toJson());
  // }

  // for (var userActivity in userActivityList) {
  //   await FirebaseFirestoreConfigs.userActivitiesCollection
  //       .doc(userActivity.id)
  //       .set(userActivity.toJson());
  // }

  // for (var thread in threadList) {
  //   await FirebaseFirestoreConfigs.projectThreadsCollection
  //       .doc(thread.id)
  //       .set(thread.toJson());
  // }

  // for (var message in messageList) {
  //   if (message is TextMessageModel) {
  //     await FirebaseFirestoreConfigs.messagesCollection
  //         .doc(message.id)
  //         .set(message.toJson());
  //   } else if (message is ImageMessageModel) {
  //     await FirebaseFirestoreConfigs.messagesCollection
  //         .doc(message.id)
  //         .set(message.toJson());
  //   } else if (message is FileMessageModel) {
  //     await FirebaseFirestoreConfigs.messagesCollection
  //         .doc(message.id)
  //         .set(message.toJson());
  //   }
  // }

  for (var task in taskList) {
    await FirebaseFirestoreConfigs.tasksCollection
        .doc(task.id)
        .set(task.toJson());
  }

  // for (var subTask in subTaskList) {
  //   await FirebaseFirestoreConfigs.subTasksCollection
  //       .doc(subTask.id)
  //       .set(subTask.toJson());
  // }

  // for (var comment in commentList) {
  //   await FirebaseFirestoreConfigs.subTaskCommentsCollection
  //       .doc(comment.id)
  //       .set(comment.toJson());
  // }

  // for (var project in projectList) {
  //   await FirebaseFirestoreConfigs.projectsCollection
  //       .doc(project.id)
  //       .set(project.toJson());
  // }

  // for (var schedule in scheduleList) {
  //   await FirebaseFirestoreConfigs.personalScheduleCollection
  //       .doc(schedule.id)
  //       .set(schedule.toJson());
  // }

  // runApp(const MyApp());

  // await generateIds(amount: 3, name: 'project_invitation');

  // for (var invitation in invitationList) {
  //   await FirebaseFirestoreConfigs.projectInvitationsCollection
  //       .doc(invitation.id)
  //       .set(invitation.toJson());
  // }

  // await UpdateUser.updateProjectInvitations(
  //     '20230831-0517-8230-a202-0089f860b83a', invitationList.map((e) => e.id).toList());
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   // @override
//   // void initState() {
//   //   WidgetsBinding.instance.addObserver(this);
//   //   super.initState();
//   // }

//   // @override
//   // void dispose() {
//   //   WidgetsBinding.instance.removeObserver(this);
//   //   super.dispose();
//   // }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   super.didChangeAppLifecycleState(state);
//   //   if (state == AppLifecycleState.resumed) {
//   //     ApplicationRepository.repository.updateUserActivity(true);
//   //   }
//   //   if (state == AppLifecycleState.paused ||
//   //       state == AppLifecycleState.inactive) {
//   //     ApplicationRepository.repository.updateUserActivity(false);
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: StreamBuilder(
//           stream: ApplicationRepository.repository
//               .userStream(ApplicationRepository.repository.userId),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final taskId = snapshot.data!.tasks.first;
//               return Center(
//                 child: StreamBuilder(
//                   stream: ApplicationRepository.repository.taskStream(taskId),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return ErrorWidget(snapshot.error.toString());
//                     }
//                     if (snapshot.hasData) {
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(snapshot.data!.project),
//                           ],
//                         ),
//                       );
//                     }
//                     return const CircularProgressIndicator();
//                   },
//                 ),
//               );
//             }
//             if (snapshot.hasError) {
//               return ErrorWidget("");
//             }
//             return const CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }

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
