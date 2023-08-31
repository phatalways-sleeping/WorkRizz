import 'package:task_managing_application/apis/storage/Delete/crud_Delete.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class DeleteMessage extends Delete {
  const DeleteMessage._() : super();

  static Future<void> deleteMessage(String id) =>
      FirebaseFirestoreConfigs.messagesCollection.doc(id).delete();
}
