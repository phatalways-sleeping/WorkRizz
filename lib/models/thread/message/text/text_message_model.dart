import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart';
import 'package:task_managing_application/models/thread/message/base/message_model.dart';

part 'text_message_model.g.dart';

// This is the model for the text message
// It contains
//  + all the properties of the message model
//  + the text of the message
@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
@DateTimeSerializer()
final class TextMessageModel extends MessageModel {
  const TextMessageModel({
    required super.reference,
    required super.id,
    required super.sender,
    required super.time,
    required this.text,
  });

  factory TextMessageModel.fromJson(Map<String, dynamic> json) =>
      _$TextMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$TextMessageModelToJson(this);

  final String text;

  @override
  List<Object> get props => [
        ...super.props,
        text,
      ];

  TextMessageModel copyWith({
    DocumentReference? reference,
    String? id,
    String? sender,
    DateTime? time,
    String? text,
  }) {
    return TextMessageModel(
      reference: reference ?? this.reference,
      id: id ?? this.id,
      sender: sender ?? this.sender,
      time: time ?? this.time,
      text: text ?? this.text,
    );
  }
}
