import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/base/base.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart';

part 'project.g.dart';

// This is the model for the project
// It contains 
//  + the reference to the document in the firestore
//  + the id of the document in the firestore
//  + the name of the project
//  + the list of the tags of the project
//  + the start date of the project
//  + the end date of the project
//  + the list of the tasks id of the project
//  + the leader id of the project
//  + the list of the assignees id of the project
//  + the list of the most active members id of the project
//  + the thread id of the project
@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
@DateTimeSerializer()
class Project extends Base {
  const Project({
    required super.reference,
    required super.id,
    required this.name,
    required this.tasks,
    required this.tags,
    required this.startDate,
    required this.endDate,
    required this.leader,
    required this.assignees,
    required this.mostActiveMemebers,
    required this.thread,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
  
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @JsonKey(required: true)
  final String name;
  @JsonKey(defaultValue: [])
  final List<String> tags;
  @JsonKey(required: true)
  final DateTime startDate;
  @JsonKey(required: true)
  final DateTime endDate;
  @JsonKey(defaultValue: [])
  final List<String> tasks;
  @JsonKey(required: true)
  final String leader;
  @JsonKey(defaultValue: [])
  final List<String> assignees;
  @JsonKey(defaultValue: [])
  final List<String> mostActiveMemebers;
  @JsonKey(required: true)
  final String thread;

  @override
  List<Object> get props => [
        ...super.props,
        name,
        tasks,
        tags,
        startDate,
        endDate,
        leader,
        assignees,
        mostActiveMemebers,
        thread,
      ];

  Project copyWith({
    DocumentReference? reference,
    String? id,
    String? name,
    List<String>? tags,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? tasks,
    String? leader,
    List<String>? assignees,
    List<String>? mostActiveMemebers,
    String? thread,
  }) {
    return Project(
      reference: reference ?? this.reference,
      id: id ?? this.id,
      name: name ?? this.name,
      tags: tags ?? this.tags,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tasks: tasks ?? this.tasks,
      leader: leader ?? this.leader,
      assignees: assignees ?? this.assignees,
      mostActiveMemebers: mostActiveMemebers ?? this.mostActiveMemebers,
      thread: thread ?? this.thread,
    );
  }
}
