// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivityModel _$UserActivityModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['lastActive'],
  );
  return UserActivityModel(
    reference: const DocumentReferenceSerializer()
        .fromJson(json['reference'] as DocumentReference<Object?>),
    id: json['id'] as String,
    isActive: json['isActive'] as bool? ?? false,
    lastActive:
        const DateTimeSerializer().fromJson(json['lastActive'] as String),
  );
}

Map<String, dynamic> _$UserActivityModelToJson(UserActivityModel instance) =>
    <String, dynamic>{
      'reference':
          const DocumentReferenceSerializer().toJson(instance.reference),
      'id': instance.id,
      'isActive': instance.isActive,
      'lastActive': const DateTimeSerializer().toJson(instance.lastActive),
    };
