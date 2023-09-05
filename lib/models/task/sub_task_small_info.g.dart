// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_task_small_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubTaskSmallInformation _$SubTaskSmallInformationFromJson(
        Map<String, dynamic> json) =>
    SubTaskSmallInformation(
      id: json['id'] as String,
      name: json['name'] as String,
      isCompleted: json['isCompleted'] as bool,
      points: json['points'] as int,
    );

Map<String, dynamic> _$SubTaskSmallInformationToJson(
        SubTaskSmallInformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'points': instance.points,
      'isCompleted': instance.isCompleted,
    };
