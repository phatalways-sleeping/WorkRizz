import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/base/base.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart';

part 'project_invitation.g.dart';


@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
final class ProjectInvitationModel extends Base {
  const ProjectInvitationModel({
    super.reference,
    required super.id,
    required this.projectId,
    required this.projectName,
    required this.projectLeaderId,
    required this.projectLeaderImageUrl,
    required this.senderId,
    required this.receiverId,
    required this.senderImageUrl,
    required this.senderEmail,
    required this.senderUsername,
    this.isAccepted = false,
  });

  factory ProjectInvitationModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectInvitationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectInvitationModelToJson(this);

  @JsonKey(required: true)
  final String projectId;
  @JsonKey(required: true)
  final String projectName;
  @JsonKey(required: true)
  final String projectLeaderId;
  @JsonKey(required: true)
  final String projectLeaderImageUrl;
  @JsonKey(required: true)
  final String senderId;
  @JsonKey(required: true)
  final String senderImageUrl;
  @JsonKey(required: true)
  final String senderEmail;
  @JsonKey(required: true)
  final String senderUsername;
  @JsonKey(required: true)
  final String receiverId;
  @JsonKey(defaultValue: false)
  final bool isAccepted;

  @override
  List<Object> get props => [
        ...super.props,
        projectId,
        projectName,
        projectLeaderId,
        projectLeaderImageUrl,
        senderId,
        receiverId,
        isAccepted,
      ];
}
