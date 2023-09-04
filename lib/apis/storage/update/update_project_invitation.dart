import 'package:task_managing_application/apis/storage/update/crud_update.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/project_invitation/project_invitation.dart';

final class UpdateProjectInvitation extends Update {
  const UpdateProjectInvitation._() : super();

  static Future<void> updateProjectInvitation(
          ProjectInvitationModel projectInvitationModel) =>
      FirebaseFirestoreConfigs.projectInvitationsCollection
          .doc(projectInvitationModel.id)
          .update(
            projectInvitationModel.toJson(),
          );

  static Future<void> updateIsAccepted(String id, bool isAccepted) =>
      FirebaseFirestoreConfigs.projectInvitationsCollection.doc(id).update(
        {
          "isAccepted": isAccepted,
        },
      );
}
