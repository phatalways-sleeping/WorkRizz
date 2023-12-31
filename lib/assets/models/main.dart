
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:task_managing_application/apis/pdf/pdf_api.dart';
// import 'project/project_data.dart';

const String path = 'lib/assets/models/';
Future<void> main() async {
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

  // for (var task in taskList) {
  //   await FirebaseFirestoreConfigs.tasksCollection
  //       .doc(task.id)
  //       .set(task.toJson());
  // }

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

  WidgetsFlutterBinding.ensureInitialized();

  PdfAPI.buildReport('20230831-0508-8d53-a880-b370f9865591').then(
    (value) => PdfAPI.openFile(value),
  );

  runApp(const MyApp());

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const PDFView(
      filePath: '/storage/emulated/0/Download/Ordinary_Coffee_House.pdf',
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: false,
    );
  }
}
