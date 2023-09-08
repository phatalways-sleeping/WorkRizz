import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/project/sub_task_small_info.dart';


part 'task_small_info.g.dart';

@JsonSerializable(explicitToJson: true)
final class TaskSmallInformation extends Equatable {
  const TaskSmallInformation({
    required this.id,
    required this.name,
    required this.subTaskSmallInformations,
  });

  factory TaskSmallInformation.fromJson(Map<String, dynamic> json) =>
      _$TaskSmallInformationFromJson(json);

  Map<String, dynamic> toJson() => _$TaskSmallInformationToJson(this);

  final String id;
  final String name;
  final List<SubTaskSmallInformation> subTaskSmallInformations;

  @override
  List<Object> get props => [
        id,
        name,
        subTaskSmallInformations,
      ];

  TaskSmallInformation copyWith({
    String? id,
    String? name,
    List<SubTaskSmallInformation>? subTaskSmallInformations,
  }) {
    return TaskSmallInformation(
      id: id ?? this.id,
      name: name ?? this.name,
      subTaskSmallInformations: subTaskSmallInformations ?? this.subTaskSmallInformations,
    );
  }
}