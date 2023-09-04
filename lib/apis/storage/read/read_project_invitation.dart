import 'package:task_managing_application/apis/storage/read/crud_read.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/project_invitation/project_invitation.dart';

final class ReadProjectInvitation extends Read {
  const ReadProjectInvitation._() : super();

  static Stream<ProjectInvitationModel> readProjectInvitation(String id) =>
      FirebaseFirestoreConfigs.projectInvitationsCollection
          .doc(id)
          .snapshots()
          .map(
            (snapshot) => ProjectInvitationModel.fromJson(
              snapshot.data()! as Map<String, dynamic>,
            ),
          );
}
