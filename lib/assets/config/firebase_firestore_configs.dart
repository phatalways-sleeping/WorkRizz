import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final class FirebaseFirestoreConfigs {
  const FirebaseFirestoreConfigs._();

  static const _usersCollection = "users";
  static const _subTasksCollection = "subTasks";
  static const _subTaskCommentsCollection = "subTaskComments";
  static const _tasksCollection = "tasks";
  static const _projectsCollection = "projects";
  static const _personalScheduleCollection = "personalSchedules";
  static const _userActivitiesCollection = "userActivities";
  static const _projectThreadsCollection = "projectThreads";
  static const _messagesCollection = "messages";

  static CollectionReference get usersCollection =>
      FirebaseFirestore.instance.collection(_usersCollection);

  static CollectionReference get subTasksCollection =>
      FirebaseFirestore.instance.collection(_subTasksCollection);

  static CollectionReference get tasksCollection =>
      FirebaseFirestore.instance.collection(_tasksCollection);

  static CollectionReference get projectsCollection =>
      FirebaseFirestore.instance.collection(_projectsCollection);

  static CollectionReference get personalScheduleCollection =>
      FirebaseFirestore.instance.collection(_personalScheduleCollection);

  static CollectionReference get userActivitiesCollection =>
      FirebaseFirestore.instance.collection(_userActivitiesCollection);

  static CollectionReference get projectThreadsCollection =>
      FirebaseFirestore.instance.collection(_projectThreadsCollection);

  static CollectionReference get messagesCollection =>
      FirebaseFirestore.instance.collection(_messagesCollection);

  static CollectionReference get subTaskCommentsCollection =>
      FirebaseFirestore.instance.collection(_subTaskCommentsCollection);

  static Reference get storageRef => FirebaseStorage.instance.ref();
}
