// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageMessageModel _$ImageMessageModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['imageUrl'],
  );
  return ImageMessageModel(
    reference: const DocumentReferenceSerializer()
        .fromJson(json['reference'] as DocumentReference<Object?>),
    id: json['id'] as String,
    sender: json['sender'] as String,
    time: const DateTimeSerializer().fromJson(json['time'] as String),
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$ImageMessageModelToJson(ImageMessageModel instance) =>
    <String, dynamic>{
      'reference':
          const DocumentReferenceSerializer().toJson(instance.reference),
      'id': instance.id,
      'sender': instance.sender,
      'time': const DateTimeSerializer().toJson(instance.time),
      'imageUrl': instance.imageUrl,
    };
