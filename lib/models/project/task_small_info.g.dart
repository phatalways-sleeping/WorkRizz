// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_small_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskSmallInformation _$TaskSmallInformationFromJson(
        Map<String, dynamic> json) =>
    TaskSmallInformation(
      id: json['id'] as String,
      name: json['name'] as String,
      subTaskSmallInformations:
          (json['subTaskSmallInformations'] as List<dynamic>)
              .map((e) =>
                  SubTaskSmallInformation.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$TaskSmallInformationToJson(
        TaskSmallInformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subTaskSmallInformations':
          instance.subTaskSmallInformations.map((e) => e.toJson()).toList(),
    };
