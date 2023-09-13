import 'package:task_managing_application/apis/storage/read/crud_read.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart';

final class ReadMessage extends Read {
  const ReadMessage._() : super();

  static Stream<MessageModel> messageStreamById(String id) =>
      FirebaseFirestoreConfigs.messagesCollection
          .doc(id)
          .snapshots()
          .map((event) {
        
        final json = event.data() as Map<String, dynamic>;
        if (json.containsKey("text")) {
          return TextMessageModel.fromJson(json);
        } else if (json.containsKey("imageUrl")) {
          return ImageMessageModel.fromJson(json);
        }
        return FileMessageModel.fromJson(json);
      });
}
