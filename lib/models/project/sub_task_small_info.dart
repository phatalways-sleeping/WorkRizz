import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_task_small_info.g.dart';

@JsonSerializable(explicitToJson: true)
final class SubTaskSmallInformation extends Equatable {
  const SubTaskSmallInformation({
    required this.id,
    required this.name,
    required this.isCompleted,
    required this.points,
    required this.assigneeImageUrl,
  });

  final String id;
  final String name;
  final int points;
  final bool isCompleted;
  final String assigneeImageUrl;

  factory SubTaskSmallInformation.fromJson(Map<String, dynamic> json) =>
      _$SubTaskSmallInformationFromJson(json);

  Map<String, dynamic> toJson() => _$SubTaskSmallInformationToJson(this);

  @override
  List<Object> get props => [
        id,
        name,
        isCompleted,
        points,
        assigneeImageUrl,
      ];

  SubTaskSmallInformation copyWith({
    String? id,
    String? name,
    bool? isCompleted,
    int? points,
    String? assigneeImageUrl,
  }) {
    return SubTaskSmallInformation(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
      points: points ?? this.points,
      assigneeImageUrl: assigneeImageUrl ?? this.assigneeImageUrl,
    );
  }
}
