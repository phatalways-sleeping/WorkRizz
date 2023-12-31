part of 'user_project_invitation_bloc.dart';

sealed class UserProjectInvitationEvent extends Equatable {
  const UserProjectInvitationEvent();

  @override
  List<Object> get props => [];
}

final class UserProjectInvitationSubscribeToStream
    extends UserProjectInvitationEvent {
  const UserProjectInvitationSubscribeToStream();
}

final class UserProjectInvitationRequestToLogout
    extends UserProjectInvitationEvent {
  const UserProjectInvitationRequestToLogout();
}

final class UserProjectInvitationCancelRequest
    extends UserProjectInvitationEvent {
  const UserProjectInvitationCancelRequest();
}