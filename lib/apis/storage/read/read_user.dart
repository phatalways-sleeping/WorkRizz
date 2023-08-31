import 'package:task_managing_application/apis/storage/read/crud_read.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart' show UserDataModel;

final class ReadUser extends Read {
  const ReadUser._(): super();
   // User
  static Stream<UserDataModel> userStreamByEmail(String email) =>
      FirebaseFirestoreConfigs.usersCollection
          .where("email", isEqualTo: email)
          .limit(1)
          .snapshots()
          .map((event) => UserDataModel.fromJson(
              event.docs.first.data() as Map<String, dynamic>));

  static Stream<UserDataModel> userStreamById(String id) =>
      FirebaseFirestoreConfigs.usersCollection.doc(id).snapshots().map(
          (event) =>
              UserDataModel.fromJson(event.data() as Map<String, dynamic>));

  static Stream<String> usernameOfUserByEmail(String email) =>
      FirebaseFirestoreConfigs.usersCollection
          .where("email", isEqualTo: email)
          .limit(1)
          .snapshots()
          .map(
            (event) => UserDataModel.fromJson(
                    event.docs.first.data() as Map<String, dynamic>)
                .username,
          );

  static Stream<String> usernameOfUserById(String id) =>
      FirebaseFirestoreConfigs.usersCollection.doc(id).snapshots().map(
            (event) =>
                UserDataModel.fromJson(event.data() as Map<String, dynamic>)
                    .username,
          );

  static Stream<String> imageUrlStreamOfUserByEmail(String email) =>
      FirebaseFirestoreConfigs.usersCollection
          .where("email", isEqualTo: email)
          .limit(1)
          .snapshots()
          .map(
            (event) => UserDataModel.fromJson(
                    event.docs.first.data() as Map<String, dynamic>)
                .imageUrl,
          );

  static Stream<String> imageUrlStreamOfUserById(String id) =>
      FirebaseFirestoreConfigs.usersCollection.doc(id).snapshots().map(
            (event) =>
                UserDataModel.fromJson(event.data() as Map<String, dynamic>)
                    .imageUrl,
          );

  static Future<String> emailOfUser(String id) => FirebaseFirestoreConfigs
      .usersCollection
      .doc(id)
      .get()
      .then((value) =>
          UserDataModel.fromJson(value.data() as Map<String, dynamic>).email)
      .onError(
        (error, stackTrace) => Future.error("Error has happened!"),
      );

}