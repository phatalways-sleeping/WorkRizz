// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubTaskModel _$SubTaskModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'assignee', 'dueDate'],
  );
  return SubTaskModel(
    reference: const DocumentReferenceSerializer()
        .fromJson(json['reference'] as DocumentReference<Object?>),
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String? ?? '',
    assignee: json['assignee'] as String,
    dueDate: const DateTimeSerializer().fromJson(json['dueDate'] as String),
    isCompleted: json['isCompleted'] as bool? ?? false,
    points: json['points'] as int? ?? 0,
    files:
        (json['files'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    comments: (json['comments'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    progress: (json['progress'] as num?)?.toDouble() ?? 0,
    grade: json['grade'] as int? ?? 0,
    leaderComment: json['leaderComment'] as String? ?? '',
  );
}

Map<String, dynamic> _$SubTaskModelToJson(SubTaskModel instance) =>
    <String, dynamic>{
      'reference':
          const DocumentReferenceSerializer().toJson(instance.reference),
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'assignee': instance.assignee,
      'dueDate': const DateTimeSerializer().toJson(instance.dueDate),
      'isCompleted': instance.isCompleted,
      'points': instance.points,
      'files': instance.files,
      'comments': instance.comments,
      'progress': instance.progress,
      'grade': instance.grade,
      'leaderComment': instance.leaderComment,
    };
