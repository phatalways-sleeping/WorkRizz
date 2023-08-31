import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/base/base.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart' show DocumentReferenceSerializer;

part 'task.g.dart';

// This is the model for the task
// It contains
//  + the reference to the document in the firestore
//  + the id of the document in the firestore
//  + the name of the task
//  + the list of the sub tasks id of the task
//  + the project id of the task
//  + the assignee id of the task
//  + the points of the task
//  + the boolean value of the task completion

@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
class Task extends Base {
  const Task({
    super.reference,
    required super.id,
    required this.name,
    required this.subTasks,
    required this.project,
    required this.points,
    required this.isCompleted,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @JsonKey(required: true)
  final String name;
  @JsonKey(defaultValue: [])
  final List<String> subTasks;
  @JsonKey(required: true)
  final String project;
  @JsonKey(defaultValue: 0)
  final int points;
  @JsonKey(defaultValue: false)
  final bool isCompleted;

  @override
  List<Object> get props => [
        ...super.props,
        name,
        subTasks,
        project,
        points,
        isCompleted,
      ];

  Task copyWith({
    String? id,
    DocumentReference? reference,
    String? name,
    List<String>? subTasks,
    String? project,
    String? assignee,
    int? points,
    bool? isCompleted,
  }) {
    return Task(
      reference: reference ?? this.reference,
      id: id ?? this.id,
      name: name ?? this.name,
      subTasks: subTasks ?? this.subTasks,
      project: project ?? this.project,
      points: points ?? this.points,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
