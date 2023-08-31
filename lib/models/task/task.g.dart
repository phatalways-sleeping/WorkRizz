// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'project'],
  );
  return Task(
    reference: const DocumentReferenceSerializer()
        .fromJson(json['reference'] as DocumentReference<Object?>),
    id: json['id'] as String,
    name: json['name'] as String,
    subTasks: (json['subTasks'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    project: json['project'] as String,
    points: json['points'] as int? ?? 0,
    isCompleted: json['isCompleted'] as bool? ?? false,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'reference':
          const DocumentReferenceSerializer().toJson(instance.reference),
      'id': instance.id,
      'name': instance.name,
      'subTasks': instance.subTasks,
      'project': instance.project,
      'points': instance.points,
      'isCompleted': instance.isCompleted,
    };
