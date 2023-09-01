import 'package:task_managing_application/apis/storage/create/crud_create.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart';

final class CreateComment extends Create {
  const CreateComment._() : super();

  static Future<void> createNewComment(CommentModel commentModel) =>
      FirebaseFirestoreConfigs.subTaskCommentsCollection
          .doc(commentModel.id)
          .set(commentModel.toJson());
}
