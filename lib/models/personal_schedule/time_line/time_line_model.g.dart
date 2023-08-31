// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_line_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineModel _$TimelineModelFromJson(Map<String, dynamic> json) =>
    TimelineModel(
      status: $enumDecodeNullable(_$TimelineStatusEnumMap, json['status']) ??
          TimelineStatus.day,
      firstHour: json['firstHour'] as String?,
      secondHour: json['secondHour'] as String?,
      thirdHour: json['thirdHour'] as String?,
      fourthHour: json['fourthHour'] as String?,
      fifthHour: json['fifthHour'] as String?,
      sixthHour: json['sixthHour'] as String?,
      seventhHour: json['seventhHour'] as String?,
      eighthHour: json['eighthHour'] as String?,
      ninthHour: json['ninthHour'] as String?,
      tenthHour: json['tenthHour'] as String?,
      eleventhHour: json['eleventhHour'] as String?,
      twelvethHour: json['twelvethHour'] as String?,
    );

Map<String, dynamic> _$TimelineModelToJson(TimelineModel instance) =>
    <String, dynamic>{
      'status': _$TimelineStatusEnumMap[instance.status]!,
      'firstHour': instance.firstHour,
      'secondHour': instance.secondHour,
      'thirdHour': instance.thirdHour,
      'fourthHour': instance.fourthHour,
      'fifthHour': instance.fifthHour,
      'sixthHour': instance.sixthHour,
      'seventhHour': instance.seventhHour,
      'eighthHour': instance.eighthHour,
      'ninthHour': instance.ninthHour,
      'tenthHour': instance.tenthHour,
      'eleventhHour': instance.eleventhHour,
      'twelvethHour': instance.twelvethHour,
    };

const _$TimelineStatusEnumMap = {
  TimelineStatus.day: 'day',
  TimelineStatus.night: 'night',
};
