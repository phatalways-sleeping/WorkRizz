// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['username', 'email'],
  );
  return UserDataModel(
    reference: const DocumentReferenceSerializer()
        .fromJson(json['reference'] as DocumentReference<Object?>),
    id: json['id'] as String,
    username: json['username'] as String,
    email: json['email'] as String,
    subTasks: (json['subTasks'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    projects: (json['projects'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    tasks:
        (json['tasks'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    personalSchedules: (json['personalSchedules'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'reference':
          const DocumentReferenceSerializer().toJson(instance.reference),
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'projects': instance.projects,
      'tasks': instance.tasks,
      'subTasks': instance.subTasks,
      'personalSchedules': instance.personalSchedules,
    };
