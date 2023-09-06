import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_managing_application/models/project_invitation/project_invitation.dart';
import 'package:task_managing_application/repositories/application_repository.dart';

part 'user_project_invitation_event.dart';
part 'user_project_invitation_state.dart';

class UserProjectInvitationBloc
    extends Bloc<UserProjectInvitationEvent, UserProjectInvitationState> {
  UserProjectInvitationBloc(
    this._applicationRepository,
  ) : super(const UserProjectInvitationInitial()) {
    on<UserProjectInvitationSubscribeToStream>((event, emit) async {
      await emit.forEach(
        _applicationRepository.projectInvitationsStreamInUser,
        onData: (data) => UserProjectInvitationSuccess(projectInvitation: data),
        onError: (error, stackTrace) => const UserProjectInvitationFailure(),
      );
    });
  }

  final ApplicationRepository _applicationRepository;

  Stream<ProjectInvitationModel> projectInvitationModelFromId(
          String projectInvitationId) =>
      _applicationRepository.projectInvitationStream(
        projectInvitationId,
      );
}
