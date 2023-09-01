import 'package:task_managing_application/models/models.dart';

import 'crud_create.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';

final class CreateMessage extends Create {
  const CreateMessage._() : super();

  static Future<void> createNewMessage(MessageModel messageModel) =>
      FirebaseFirestoreConfigs.messagesCollection.doc(messageModel.id).set(
            messageModel is TextMessageModel
                ? messageModel.toJson()
                : messageModel is ImageMessageModel
                    ? messageModel.toJson()
                    : (messageModel as FileMessageModel).toJson(),
          );
}
