part of 'invitation_bloc.dart';

sealed class InvitationEvent extends Equatable {
  const InvitationEvent();

  @override
  List<Object> get props => [];
}

final class InvitationSubscribeToStream extends InvitationEvent {
  const InvitationSubscribeToStream(this.id);

  final String id;

  @override
  List<Object> get props => [...super.props, id];
}

final class InvitationAccept extends InvitationEvent {
  const InvitationAccept({
    required this.projectInvitationId,
  });

  final String projectInvitationId;

  @override
  List<Object> get props => [...super.props, projectInvitationId];
}

final class InvitationDecline extends InvitationEvent {
  const InvitationDecline({
    required this.projectInvitationId,
  });

  final String projectInvitationId;

  @override
  List<Object> get props => [...super.props, projectInvitationId];
}