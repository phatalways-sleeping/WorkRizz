import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/json_converters/datetime_serializer.dart';

part 'file_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeSerializer()
final class FileModel extends Equatable {
  const FileModel({
    required this.fileName,
    required this.uploadDate,
    required this.ownerId,
    required this.ownerImageUrl,
    required this.ownerName,
  });

  final String fileName;
  final DateTime uploadDate;
  final String ownerId;
  final String ownerImageUrl;
  final String ownerName;

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);


  @override
  List<Object?> get props => [
    fileName,
    uploadDate,
    ownerId,
    ownerImageUrl,
    ownerName,
  ];

  FileModel copyWith({
    String? fileName,
    DateTime? uploadDate,
    String? ownerId,
    String? ownerImageUrl,
    String? ownerName,
  }) {
    return FileModel(
      fileName: fileName ?? this.fileName,
      uploadDate: uploadDate ?? this.uploadDate,
      ownerId: ownerId ?? this.ownerId,
      ownerImageUrl: ownerImageUrl ?? this.ownerImageUrl,
      ownerName: ownerName ?? this.ownerName,
    );
  }
}
