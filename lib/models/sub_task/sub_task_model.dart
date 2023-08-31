import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/base/base.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart';

part 'sub_task_model.g.dart';

// This is the model for the sub task
// It contains
//  + the reference to the document in the firestore
//  + the id of the document in the firestore
//  + the name of the sub task
//  + the description of the sub task
//  + the assignee id of the sub task
//  + the due date of the sub task
//  + the boolean value of the sub task completion
//  + the points of the sub task
//  + the list of the files of the sub task
//  + the list of the comments of the sub task
//  + the progress of the sub task
//  + the grade of the sub task
//  + the leader comment of the sub task

@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
@DateTimeSerializer()
class SubTaskModel extends Base {
  const SubTaskModel({
    super.reference,
    required super.id,
    required this.name,
    required this.description,
    required this.assignee,
    required this.dueDate,
    required this.isCompleted,
    required this.points,
    required this.files,
    required this.comments,
    required this.progress,
    required this.grade,
    required this.leaderComment,
  });

  factory SubTaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubTaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubTaskModelToJson(this);

  @JsonKey(required: true)
  final String name;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(required: true)
  final String assignee;
  @JsonKey(required: true)
  final DateTime dueDate;
  @JsonKey(defaultValue: false)
  final bool isCompleted;
  @JsonKey(defaultValue: 0)
  final int points;
  @JsonKey(defaultValue: [])
  final List<String> files;
  @JsonKey(defaultValue: [])
  final List<String> comments;
  @JsonKey(defaultValue: 0)
  final double progress;
  @JsonKey(defaultValue: 0)
  final int grade;
  @JsonKey(defaultValue: '')
  final String leaderComment;

  @override
  List<Object> get props => [
        ...super.props,
        name,
        description,
        assignee,
        dueDate,
        isCompleted,
        points,
        files,
        comments,
        progress,
        grade,
        leaderComment,
      ];

  SubTaskModel copyWith({
    String? id,
    DocumentReference? reference,
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<String>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
  }) {
    return SubTaskModel(
      reference: reference?? this.reference,
      id: id?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      assignee: assignee ?? this.assignee,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      points: points ?? this.points,
      files: files ?? this.files,
      comments: comments ?? this.comments,
      progress: progress ?? this.progress,
      grade: grade ?? this.grade,
      leaderComment: leaderComment ?? this.leaderComment,
    );
  }
}
