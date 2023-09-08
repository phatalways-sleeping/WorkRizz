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
    reference: _$JsonConverterFromJson<DocumentReference<Object?>,
            DocumentReference<Object?>>(
        json['reference'], const DocumentReferenceSerializer().fromJson),
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String? ?? '',
    assignee: json['assignee'] as String,
    dueDate: const DateTimeSerializer().fromJson(json['dueDate'] as String),
    isCompleted: json['isCompleted'] as bool? ?? false,
    points: json['points'] as int? ?? 0,
    files: (json['files'] as List<dynamic>?)
            ?.map((e) => FileModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
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
      'reference': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.reference, const DocumentReferenceSerializer().toJson),
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'assignee': instance.assignee,
      'dueDate': const DateTimeSerializer().toJson(instance.dueDate),
      'isCompleted': instance.isCompleted,
      'points': instance.points,
      'files': instance.files.map((e) => e.toJson()).toList(),
      'comments': instance.comments,
      'progress': instance.progress,
      'grade': instance.grade,
      'leaderComment': instance.leaderComment,
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
