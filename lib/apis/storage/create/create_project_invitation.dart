import 'package:task_managing_application/apis/storage/create/crud_create.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/project_invitation/project_invitation.dart';

final class CreateProjectInvitation extends Create {
  const CreateProjectInvitation._() : super();

  static Future<void> createNewProjectInvitation(
          ProjectInvitationModel projectInvitationModel) =>
      FirebaseFirestoreConfigs.projectInvitationsCollection
          .doc(projectInvitationModel.id)
          .set(projectInvitationModel.toJson());
}