import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/base/base.dart';

import 'package:task_managing_application/models/json_converters/document_reference_serializer.dart'
    show DocumentReferenceSerializer;

part 'user_data_model.g.dart';

// This is the model for the user data
// It contains
//    + the reference to the document in the firestore
//    + the id of the document in the firestore
//    + the username of the user
//    + the email of the user
//    + the list of the projects id the user is in
//    + the list of the tasks id the user is assigned to
//    + the list of the sub task id the user is assigned to
//    + the list of the personal schedule id the user created
@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
class UserDataModel extends Base {
  const UserDataModel({
    super.reference,
    required super.id,
    required this.username,
    required this.email,
    required this.subTasks,
    required this.projects,
    required this.tasks,
    required this.personalSchedules,
    required this.imageUrl,
    this.completedProjects = 0,
    this.leaderProjects = 0,
    this.onGoingProjects = 0,
    this.projectInvitations = const [],
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

  @JsonKey(required: true)
  // This is the username of the user
  final String username;
  @JsonKey(required: true)
  // This is the email of the user
  final String email;
  @JsonKey(defaultValue: [])
  // This is the list of the projects id the user is in
  final List<String> projects;
  @JsonKey(required: true)
  final String imageUrl;
  @JsonKey(defaultValue: [])
  // This is the list of the tasks id the user is assigned to
  final List<String> tasks;
  @JsonKey(defaultValue: [])
  // This is the list of the sub task id the user is assigned to
  final List<String> subTasks;
  @JsonKey(defaultValue: [])
  // This is the list of the personal schedule id the user created
  final List<String> personalSchedules;
  @JsonKey(defaultValue: 0)
  final int completedProjects;
  @JsonKey(defaultValue: 0)
  final int leaderProjects;
  @JsonKey(defaultValue: 0)
  final int onGoingProjects;
  @JsonKey(defaultValue: [])
  final List<String> projectInvitations;

  @override
  List<Object> get props => [
        ...super.props,
        username,
        email,
        subTasks,
        projects,
        tasks,
        personalSchedules,
        imageUrl,
        completedProjects,
        onGoingProjects,
        leaderProjects,
        projectInvitations,
      ];

  UserDataModel copyWith({
    DocumentReference? reference,
    String? id,
    String? username,
    String? email,
    List<String>? subTasks,
    List<String>? projects,
    List<String>? tasks,
    List<String>? personalSchedules,
    List<String>? projectInvitations,
    String? imageUrl,
    int? completedProjects,
    int? onGoingProjects,
    int? leaderProjects,
  }) {
    return UserDataModel(
      reference: reference ?? this.reference,
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      subTasks: subTasks ?? this.subTasks,
      projects: projects ?? this.projects,
      tasks: tasks ?? this.tasks,
      personalSchedules: personalSchedules ?? this.personalSchedules,
      imageUrl: imageUrl ?? this.imageUrl,
      leaderProjects: leaderProjects ?? this.leaderProjects,
      onGoingProjects: onGoingProjects ?? this.onGoingProjects,
      completedProjects: completedProjects ?? this.completedProjects,
      projectInvitations: projectInvitations ?? this.projectInvitations,
    );
  }
}
