import 'package:task_managing_application/apis/storage/create/crud_create.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart'
    show UserDataModel;

final class CreateUser extends Create {
  const CreateUser._() : super();

  static Future<void> createUser(
    UserDataModel newUser,
  ) =>
      FirebaseFirestoreConfigs.usersCollection
          .doc(newUser.id)
          .set(newUser.toJson());
}
