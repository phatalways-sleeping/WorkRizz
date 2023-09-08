import 'package:task_managing_application/apis/storage/read/crud_read.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart';

final class ReadComment extends Read {
  const ReadComment._() : super();

  static Stream<CommentModel> commentById(String id) =>
      FirebaseFirestoreConfigs.subTaskCommentsCollection.doc(id).snapshots().map(
            (snapshot) => CommentModel.fromJson(
              snapshot.data() as Map<String, dynamic>,
            ),
          );
}
