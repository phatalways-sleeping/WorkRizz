part of 'avatar_bloc.dart';

sealed class AvatarEvent extends Equatable {
  const AvatarEvent();

  @override
  List<Object> get props => [];
}

final class AvatarSubscribeToUserEvent extends AvatarEvent {
  const AvatarSubscribeToUserEvent();
}