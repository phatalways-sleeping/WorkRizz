import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_managing_application/repositories/repositories.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  AvatarBloc(this._applicationRepository) : super(const AvatarInitial()) {
    on<AvatarSubscribeToUserEvent>(
      (event, emit) async {
        await emit.forEach(
          _applicationRepository.userStream(_applicationRepository.userId),
          onData: (user) => AvatarUserSubscription(
            imageUrl: user.imageUrl,
            notifications: user.projectInvitations,
          ),
          onError: (error, stackTrace) => const AvatarError(),
        );
      },
    );
  }

  final ApplicationRepository _applicationRepository;

  Future<String> get imageUrlFuture =>
      _applicationRepository.imageUrlOnStorageOf(state.imageUrl!);
}
