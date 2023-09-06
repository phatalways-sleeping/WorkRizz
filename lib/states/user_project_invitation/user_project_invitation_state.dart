part of 'user_project_invitation_bloc.dart';

sealed class UserProjectInvitationState extends Equatable {
  const UserProjectInvitationState({
    this.projectInvitation,
  });

  final List<String>? projectInvitation;

  @override
  List<Object> get props => [
        ...projectInvitation ?? [],
      ];
}

final class UserProjectInvitationInitial extends UserProjectInvitationState {
  const UserProjectInvitationInitial();
}

final class UserProjectInvitationLoading extends UserProjectInvitationState {
  const UserProjectInvitationLoading({
    required super.projectInvitation,
  });
}

final class UserProjectInvitationSuccess extends UserProjectInvitationState {
  const UserProjectInvitationSuccess({
    required super.projectInvitation,
  });
}

final class UserProjectInvitationFailure extends UserProjectInvitationState {
  const UserProjectInvitationFailure(this.message);

  final String message;

  @override
  List<Object> get props => [
        ...super.props,
        message,
      ];
}
