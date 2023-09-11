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
    reference: _$JsonConverterFromJson<DocumentReference<Object?>,
            DocumentReference<Object?>>(
        json['reference'], const DocumentReferenceSerializer().fromJson),
    id: json['id'] as String,
    sender: json['sender'] as String,
    time: const DateTimeSerializer().fromJson(json['time'] as String),
    fileUrl: json['fileUrl'] as String,
    fileName: json['fileName'] as String,
    fileType: $enumDecode(_$FileTypeModeEnumMap, json['fileType']),
  );
}

Map<String, dynamic> _$FileMessageModelToJson(FileMessageModel instance) =>
    <String, dynamic>{
      'reference': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.reference, const DocumentReferenceSerializer().toJson),
      'id': instance.id,
      'sender': instance.sender,
      'time': const DateTimeSerializer().toJson(instance.time),
      'fileUrl': instance.fileUrl,
      'fileName': instance.fileName,
      'fileType': _$FileTypeModeEnumMap[instance.fileType]!,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$FileTypeModeEnumMap = {
  FileTypeMode.pdf: 'pdf',
  FileTypeMode.txt: 'txt',
  FileTypeMode.csv: 'csv',
  FileTypeMode.doc: 'doc',
  FileTypeMode.xls: 'xls',
  FileTypeMode.ppt: 'ppt',
  FileTypeMode.other: 'other',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
