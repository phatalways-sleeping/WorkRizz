// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessageModel _$TextMessageModelFromJson(Map<String, dynamic> json) =>
    TextMessageModel(
      reference: const DocumentReferenceSerializer()
          .fromJson(json['reference'] as DocumentReference<Object?>),
      id: json['id'] as String,
      sender: json['sender'] as String,
      time: const DateTimeSerializer().fromJson(json['time'] as String),
      text: json['text'] as String,
    );

Map<String, dynamic> _$TextMessageModelToJson(TextMessageModel instance) =>
    <String, dynamic>{
      'reference':
          const DocumentReferenceSerializer().toJson(instance.reference),
      'id': instance.id,
      'sender': instance.sender,
      'time': const DateTimeSerializer().toJson(instance.time),
      'text': instance.text,
    };
