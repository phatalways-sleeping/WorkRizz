import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/base/base.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart';
import 'package:task_managing_application/models/project/files_small_info.dart';
import 'package:task_managing_application/models/project/task_small_info.dart';
import 'package:task_managing_application/models/tag/tag.dart';

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
    super.reference,
    required super.id,
    required this.name,
    required this.tasks,
    required this.tags,
    required this.startDate,
    required this.endDate,
    required this.leader,
    required this.leaderImageUrl,
    required this.assignees,
    required this.assigneeImageUrls,
    required this.mostActiveMemebers,
    required this.thread,
    required this.creatorId,
    this.isCompleted = false,
    this.tasksCompleted = 0,
    this.activitiesCompleted = 0,
    this.totalActivities = 0,
    this.totalFileLinks = 0,
    this.taskSmallInformations = const [],
    this.filesSmallInformations = const [],
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @JsonKey(required: true)
  final String name;
  @JsonKey(defaultValue: [])
  final List<Tag> tags;
  @JsonKey(required: true)
  final DateTime startDate;
  @JsonKey(required: true)
  final DateTime endDate;
  @JsonKey(defaultValue: [])
  final List<String> tasks;
  @JsonKey(required: true)
  final String leader;
  @JsonKey(required: true)
  final String creatorId;
  @JsonKey(required: true)
  final String leaderImageUrl;
  @JsonKey(defaultValue: [])
  final List<String> assignees;
  @JsonKey(defaultValue: [])
  final List<String> assigneeImageUrls;
  @JsonKey(defaultValue: [])
  final List<String> mostActiveMemebers;
  @JsonKey(required: true)
  final String thread;
  @JsonKey(defaultValue: false)
  final bool isCompleted;
  @JsonKey(defaultValue: 0)
  final int tasksCompleted;
  @JsonKey(defaultValue: 0)
  final int activitiesCompleted;
  @JsonKey(defaultValue: 0)
  final int totalActivities;
  @JsonKey(defaultValue: 0)
  final int totalFileLinks;
  @JsonKey(defaultValue: [])
  final List<TaskSmallInformation> taskSmallInformations;
  @JsonKey()
  final List<FilesSmallInformation> filesSmallInformations;

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
        isCompleted,
        totalActivities,
        tasksCompleted,
        activitiesCompleted,
        leaderImageUrl,
        assigneeImageUrls,
        totalFileLinks,
        creatorId,
        taskSmallInformations,
        filesSmallInformations,
      ];

  Project copyWith({
    DocumentReference? reference,
    String? id,
    String? name,
    List<Tag>? tags,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? tasks,
    String? leader,
    String? creatorId,
    List<String>? assignees,
    List<String>? mostActiveMemebers,
    String? thread,
    bool? isCompleted,
    int? totalActivities,
    int? tasksCompleted,
    int? activitiesCompleted,
    String? leaderImageUrl,
    List<String>? assigneeImageUrls,
    int? totalFileLinks,
    List<TaskSmallInformation>? taskSmallInformations,
    List<FilesSmallInformation>? filesSmallInformations,
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
      creatorId: creatorId ?? this.creatorId,
      leaderImageUrl: leaderImageUrl ?? this.leaderImageUrl,
      assignees: assignees ?? this.assignees,
      assigneeImageUrls: assigneeImageUrls ?? this.assigneeImageUrls,
      mostActiveMemebers: mostActiveMemebers ?? this.mostActiveMemebers,
      thread: thread ?? this.thread,
      isCompleted: isCompleted ?? this.isCompleted,
      totalActivities: totalActivities ?? this.totalActivities,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      activitiesCompleted: activitiesCompleted ?? this.activitiesCompleted,
      totalFileLinks: totalFileLinks ?? this.totalFileLinks,
      taskSmallInformations:
          taskSmallInformations ?? this.taskSmallInformations,
      filesSmallInformations:
          filesSmallInformations ?? this.filesSmallInformations,
    );
  }
}
