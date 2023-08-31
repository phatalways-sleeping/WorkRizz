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
    reference: _$JsonConverterFromJson<DocumentReference<Object?>,
            DocumentReference<Object?>>(
        json['reference'], const DocumentReferenceSerializer().fromJson),
    id: json['id'] as String,
    sender: json['sender'] as String,
    time: const DateTimeSerializer().fromJson(json['time'] as String),
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$ImageMessageModelToJson(ImageMessageModel instance) =>
    <String, dynamic>{
      'reference': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.reference, const DocumentReferenceSerializer().toJson),
      'id': instance.id,
      'sender': instance.sender,
      'time': const DateTimeSerializer().toJson(instance.time),
      'imageUrl': instance.imageUrl,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
