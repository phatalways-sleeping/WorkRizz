// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files_small_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilesSmallInformation _$FilesSmallInformationFromJson(
        Map<String, dynamic> json) =>
    FilesSmallInformation(
      taskId: json['taskId'] as String,
      taskName: json['taskName'] as String,
      files: (json['files'] as List<dynamic>)
          .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilesSmallInformationToJson(
        FilesSmallInformation instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'taskName': instance.taskName,
      'files': instance.files.map((e) => e.toJson()).toList(),
    };
