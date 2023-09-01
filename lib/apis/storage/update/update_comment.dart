import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

import 'crud_update.dart';

final class UpdateComment extends Update {
  const UpdateComment._() : super();

  static Future<void> updateSolvedInComment(String id, bool solved) =>
      FirebaseFirestoreConfigs.subTaskCommentsCollection.doc(id).update({
        "solved": solved,
      });

  static Future<void> updateIsRepliedInComment(String id, bool isReplied) =>
      FirebaseFirestoreConfigs.subTaskCommentsCollection.doc(id).update({
        "isReplied": isReplied,
      });

  static Future<void> updateReplyCommentIdInComment(String id, String replyCommentId) =>
      FirebaseFirestoreConfigs.subTaskCommentsCollection.doc(id).update({
        "replyCommentId": replyCommentId,
      });
}
