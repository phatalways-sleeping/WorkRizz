import 'package:task_managing_application/models/base/base.dart';
// This is the model for the message
// It contains
//  + the reference to the document in the firestore
//  + the id of the document in the firestore
//  + the sender of the message
//  + the date time of the message
abstract class MessageModel extends Base {
  const MessageModel({
    required super.reference,
    required super.id,
    required this.sender,
    required this.time,
  });

  final String sender;
  final DateTime time;

  @override
  List<Object> get props => [
        ...super.props,
        sender,
        time,
      ];
}



