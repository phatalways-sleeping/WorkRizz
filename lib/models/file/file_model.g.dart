// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
      fileName: json['fileName'] as String,
      uploadDate:
          const DateTimeSerializer().fromJson(json['uploadDate'] as String),
      ownerId: json['ownerId'] as String,
      ownerImageUrl: json['ownerImageUrl'] as String,
      ownerName: json['ownerName'] as String,
    );

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'fileName': instance.fileName,
      'uploadDate': const DateTimeSerializer().toJson(instance.uploadDate),
      'ownerId': instance.ownerId,
      'ownerImageUrl': instance.ownerImageUrl,
      'ownerName': instance.ownerName,
    };
