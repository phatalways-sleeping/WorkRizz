part of 'invitation_bloc.dart';

sealed class InvitationState extends Equatable {
  const InvitationState();
  
  @override
  List<Object> get props => [];
}

final class InvitationInitial extends InvitationState {
  const InvitationInitial();
}

final class InvitationLoading extends InvitationState {
  const InvitationLoading();
}

final class InvitationSuccess extends InvitationState {
  const InvitationSuccess({
    required this.projectInvitation,
  });

  final ProjectInvitationModel projectInvitation;

  @override
  List<Object> get props => [...super.props, projectInvitation];
}

final class InvitationFailure extends InvitationState {
  const InvitationFailure();
}
