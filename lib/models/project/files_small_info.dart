import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/file/file_model.dart';

part 'files_small_info.g.dart';

@JsonSerializable(explicitToJson: true)
final class FilesSmallInformation extends Equatable {
  const FilesSmallInformation({
    required this.taskId,
    required this.taskName,
    required this.files,
  });

  final String taskId;
  final String taskName;
  final List<FileModel> files;

  factory FilesSmallInformation.fromJson(Map<String, dynamic> json) =>
      _$FilesSmallInformationFromJson(json);

  Map<String, dynamic> toJson() => _$FilesSmallInformationToJson(this);

  @override
  List<Object?> get props => [
        taskId,
        taskName,
        files,
      ];

  FilesSmallInformation copyWith({
    String? taskId,
    String? taskName,
    List<FileModel>? files,
  }) {
    return FilesSmallInformation(
      taskId: taskId ?? this.taskId,
      taskName: taskName ?? this.taskName,
      files: files ?? this.files,
    );
  }
}
