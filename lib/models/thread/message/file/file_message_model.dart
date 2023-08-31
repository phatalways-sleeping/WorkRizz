import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart';
import 'package:task_managing_application/models/thread/message/base/message_model.dart';

part 'file_message_model.g.dart';

enum FileType {
  pdf,
  doc,
  xls,
  ppt,
  other,
}

// This is the model for the file message
// It contains
//  + all the properties of the message model
//  + the file url of the message in the firebase storage
//  + the file name of the message
//  + the file type of the message
@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
@DateTimeSerializer()
class FileMessageModel extends MessageModel {
  const FileMessageModel({
    super.reference,
    required super.id,
    required super.sender,
    required super.time,
    required this.fileUrl,
    required this.fileName,
    required this.fileType,
  });

  factory FileMessageModel.fromJson(Map<String, dynamic> json) =>
      _$FileMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileMessageModelToJson(this);

  @JsonKey(required: true)
  final String fileUrl;
  @JsonKey(required: true)
  final String fileName;
  @JsonKey(required: true)
  final FileType fileType;

  @override
  List<Object> get props => [
        ...super.props,
        fileUrl,
        fileName,
        fileType,
      ];

  FileMessageModel copyWith({
    DocumentReference? reference,
    String? id,
    String? sender,
    DateTime? time,
    String? fileUrl,
    String? fileName,
    FileType? fileType,
  }) {
    return FileMessageModel(
      reference: reference ?? this.reference,
      id: id ?? this.id,
      sender: sender ?? this.sender,
      time: time ?? this.time,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
    );
  }
}
