import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_managing_application/models/project_invitation/project_invitation.dart';
import 'package:task_managing_application/repositories/application_repository.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  InvitationBloc(this._applicationRepository)
      : super(const InvitationInitial()) {
    on<InvitationSubscribeToStream>((event, emit) async {
      await emit.forEach(
        _applicationRepository.projectInvitationStream(event.id),
        onData: (data) => InvitationSuccess(projectInvitation: data),
        onError: (error, stackTrace) => const InvitationFailure(),
      );
    });
    on<InvitationAccept>((event, emit) async {
      emit(const InvitationLoading());
      await _applicationRepository.acceptProjectInvitation(
        projectInvitationId: event.projectInvitationId,
      );
    });
    on<InvitationDecline>((event, emit) async {
      emit(const InvitationLoading());
      await _applicationRepository.rejectProjectInvitation(
        projectInvitationId: event.projectInvitationId,
      );
    });
  }

  final ApplicationRepository _applicationRepository;

  Future<String> imageOfCreator() => _applicationRepository.imageUrlOnStorageOf(
        (state as InvitationSuccess).projectInvitation.senderImageUrl,
      );

  bool get isLeader =>
      (state as InvitationSuccess).projectInvitation.projectLeaderId ==
      _applicationRepository.userId;
}
