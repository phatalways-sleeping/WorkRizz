// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileMessageModel _$FileMessageModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['fileUrl', 'fileName', 'fileType'],
  );
  return FileMessageModel(
    reference: const DocumentReferenceSerializer()
        .fromJson(json['reference'] as DocumentReference<Object?>),
    id: json['id'] as String,
    sender: json['sender'] as String,
    time: const DateTimeSerializer().fromJson(json['time'] as String),
    fileUrl: json['fileUrl'] as String,
    fileName: json['fileName'] as String,
    fileType: $enumDecode(_$FileTypeEnumMap, json['fileType']),
  );
}

Map<String, dynamic> _$FileMessageModelToJson(FileMessageModel instance) =>
    <String, dynamic>{
      'reference':
          const DocumentReferenceSerializer().toJson(instance.reference),
      'id': instance.id,
      'sender': instance.sender,
      'time': const DateTimeSerializer().toJson(instance.time),
      'fileUrl': instance.fileUrl,
      'fileName': instance.fileName,
      'fileType': _$FileTypeEnumMap[instance.fileType]!,
    };

const _$FileTypeEnumMap = {
  FileType.pdf: 'pdf',
  FileType.doc: 'doc',
  FileType.xls: 'xls',
  FileType.ppt: 'ppt',
  FileType.other: 'other',
};
