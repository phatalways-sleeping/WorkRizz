import 'package:task_managing_application/apis/storage/create/crud_create.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/thread/message/base/message_model.dart';

final class CreateMessage extends Create {
  const CreateMessage._() : super();

  static Future<void> createNewMessage(MessageModel messageModel) =>
      FirebaseFirestoreConfigs.messagesCollection
          .doc(messageModel.id)
          .set(messageModel.toString());
}
