// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalScheduleModel _$PersonalScheduleModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['date', 'schedule'],
  );
  return PersonalScheduleModel(
    id: json['id'] as String,
    reference: _$JsonConverterFromJson<DocumentReference<Object?>,
            DocumentReference<Object?>>(
        json['reference'], const DocumentReferenceSerializer().fromJson),
    date: const DateTimeSerializer().fromJson(json['date'] as String),
    schedule: TimelineModel.fromJson(json['schedule'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PersonalScheduleModelToJson(
        PersonalScheduleModel instance) =>
    <String, dynamic>{
      'reference': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.reference, const DocumentReferenceSerializer().toJson),
      'id': instance.id,
      'date': const DateTimeSerializer().toJson(instance.date),
      'schedule': instance.schedule.toJson(),
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
