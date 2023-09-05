// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectInvitationModel _$ProjectInvitationModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'projectId',
      'projectName',
      'projectLeaderId',
      'projectLeaderImageUrl',
      'senderId',
      'senderImageUrl',
      'senderEmail',
      'senderUsername',
      'receiverId'
    ],
  );
  return ProjectInvitationModel(
    reference: _$JsonConverterFromJson<DocumentReference<Object?>,
            DocumentReference<Object?>>(
        json['reference'], const DocumentReferenceSerializer().fromJson),
    id: json['id'] as String,
    projectId: json['projectId'] as String,
    projectName: json['projectName'] as String,
    projectLeaderId: json['projectLeaderId'] as String,
    projectLeaderImageUrl: json['projectLeaderImageUrl'] as String,
    senderId: json['senderId'] as String,
    receiverId: json['receiverId'] as String,
    senderImageUrl: json['senderImageUrl'] as String,
    senderEmail: json['senderEmail'] as String,
    senderUsername: json['senderUsername'] as String,
    isAccepted: json['isAccepted'] as bool? ?? false,
  );
}

Map<String, dynamic> _$ProjectInvitationModelToJson(
        ProjectInvitationModel instance) =>
    <String, dynamic>{
      'reference': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.reference, const DocumentReferenceSerializer().toJson),
      'id': instance.id,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'projectLeaderId': instance.projectLeaderId,
      'projectLeaderImageUrl': instance.projectLeaderImageUrl,
      'senderId': instance.senderId,
      'senderImageUrl': instance.senderImageUrl,
      'senderEmail': instance.senderEmail,
      'senderUsername': instance.senderUsername,
      'receiverId': instance.receiverId,
      'isAccepted': instance.isAccepted,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
