// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'name',
      'subTasksCompleted',
      'project',
      'subTaskSmallInformations'
    ],
  );
  return Task(
    reference: _$JsonConverterFromJson<DocumentReference<Object?>,
            DocumentReference<Object?>>(
        json['reference'], const DocumentReferenceSerializer().fromJson),
    id: json['id'] as String,
    name: json['name'] as String,
    subTasks: (json['subTasks'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    project: json['project'] as String,
    points: json['points'] as int? ?? 0,
    isCompleted: json['isCompleted'] as bool? ?? false,
    subTasksCompleted: json['subTasksCompleted'] as int? ?? 0,
    subTaskSmallInformations:
        (json['subTaskSmallInformations'] as List<dynamic>?)
                ?.map((e) =>
                    SubTaskSmallInformation.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'reference': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.reference, const DocumentReferenceSerializer().toJson),
      'id': instance.id,
      'name': instance.name,
      'subTasks': instance.subTasks,
      'subTasksCompleted': instance.subTasksCompleted,
      'project': instance.project,
      'points': instance.points,
      'isCompleted': instance.isCompleted,
      'subTaskSmallInformations':
          instance.subTaskSmallInformations.map((e) => e.toJson()).toList(),
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
