// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'startDate', 'endDate', 'leader', 'thread'],
  );
  return Project(
    reference: const DocumentReferenceSerializer()
        .fromJson(json['reference'] as DocumentReference<Object?>),
    id: json['id'] as String,
    name: json['name'] as String,
    tasks:
        (json['tasks'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
        [],
    startDate: const DateTimeSerializer().fromJson(json['startDate'] as String),
    endDate: const DateTimeSerializer().fromJson(json['endDate'] as String),
    leader: json['leader'] as String,
    assignees: (json['assignees'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    mostActiveMemebers: (json['mostActiveMemebers'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    thread: json['thread'] as String,
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'reference':
          const DocumentReferenceSerializer().toJson(instance.reference),
      'id': instance.id,
      'name': instance.name,
      'tags': instance.tags,
      'startDate': const DateTimeSerializer().toJson(instance.startDate),
      'endDate': const DateTimeSerializer().toJson(instance.endDate),
      'tasks': instance.tasks,
      'leader': instance.leader,
      'assignees': instance.assignees,
      'mostActiveMemebers': instance.mostActiveMemebers,
      'thread': instance.thread,
    };
