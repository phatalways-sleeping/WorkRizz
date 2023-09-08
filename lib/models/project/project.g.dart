// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'name',
      'startDate',
      'endDate',
      'leader',
      'creatorId',
      'leaderImageUrl',
      'thread'
    ],
  );
  return Project(
    reference: _$JsonConverterFromJson<DocumentReference<Object?>,
            DocumentReference<Object?>>(
        json['reference'], const DocumentReferenceSerializer().fromJson),
    id: json['id'] as String,
    name: json['name'] as String,
    tasks:
        (json['tasks'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    tags: (json['tags'] as List<dynamic>?)
            ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    startDate: const DateTimeSerializer().fromJson(json['startDate'] as String),
    endDate: const DateTimeSerializer().fromJson(json['endDate'] as String),
    leader: json['leader'] as String,
    leaderImageUrl: json['leaderImageUrl'] as String,
    assignees: (json['assignees'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    assigneeImageUrls: (json['assigneeImageUrls'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    mostActiveMemebers: (json['mostActiveMemebers'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    thread: json['thread'] as String,
    creatorId: json['creatorId'] as String,
    isCompleted: json['isCompleted'] as bool? ?? false,
    tasksCompleted: json['tasksCompleted'] as int? ?? 0,
    activitiesCompleted: json['activitiesCompleted'] as int? ?? 0,
    totalActivities: json['totalActivities'] as int? ?? 0,
    totalFileLinks: json['totalFileLinks'] as int? ?? 0,
    taskSmallInformations: (json['taskSmallInformations'] as List<dynamic>?)
            ?.map(
                (e) => TaskSmallInformation.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    filesSmallInformations: (json['filesSmallInformations'] as List<dynamic>?)
            ?.map((e) =>
                FilesSmallInformation.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'reference': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.reference, const DocumentReferenceSerializer().toJson),
      'id': instance.id,
      'name': instance.name,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
      'startDate': const DateTimeSerializer().toJson(instance.startDate),
      'endDate': const DateTimeSerializer().toJson(instance.endDate),
      'tasks': instance.tasks,
      'leader': instance.leader,
      'creatorId': instance.creatorId,
      'leaderImageUrl': instance.leaderImageUrl,
      'assignees': instance.assignees,
      'assigneeImageUrls': instance.assigneeImageUrls,
      'mostActiveMemebers': instance.mostActiveMemebers,
      'thread': instance.thread,
      'isCompleted': instance.isCompleted,
      'tasksCompleted': instance.tasksCompleted,
      'activitiesCompleted': instance.activitiesCompleted,
      'totalActivities': instance.totalActivities,
      'totalFileLinks': instance.totalFileLinks,
      'taskSmallInformations':
          instance.taskSmallInformations.map((e) => e.toJson()).toList(),
      'filesSmallInformations':
          instance.filesSmallInformations.map((e) => e.toJson()).toList(),
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
