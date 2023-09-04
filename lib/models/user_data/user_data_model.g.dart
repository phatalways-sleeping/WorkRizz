// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['username', 'email', 'imageUrl'],
  );
  return UserDataModel(
    reference: _$JsonConverterFromJson<DocumentReference<Object?>,
            DocumentReference<Object?>>(
        json['reference'], const DocumentReferenceSerializer().fromJson),
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
    imageUrl: json['imageUrl'] as String,
    completedProjects: json['completedProjects'] as int? ?? 0,
    leaderProjects: json['leaderProjects'] as int? ?? 0,
    onGoingProjects: json['onGoingProjects'] as int? ?? 0,
    projectInvitations: (json['projectInvitations'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'reference': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.reference, const DocumentReferenceSerializer().toJson),
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'projects': instance.projects,
      'imageUrl': instance.imageUrl,
      'tasks': instance.tasks,
      'subTasks': instance.subTasks,
      'personalSchedules': instance.personalSchedules,
      'completedProjects': instance.completedProjects,
      'leaderProjects': instance.leaderProjects,
      'onGoingProjects': instance.onGoingProjects,
      'projectInvitations': instance.projectInvitations,
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
