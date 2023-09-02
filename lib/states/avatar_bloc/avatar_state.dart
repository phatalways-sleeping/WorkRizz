part of 'avatar_bloc.dart';

sealed class AvatarState extends Equatable {
  const AvatarState({
    this.imageUrl,
    this.notifications,
  });

  final String? imageUrl;
  final List<String>? notifications;

  @override
  List<Object> get props => [
        if (imageUrl != null) imageUrl!,
        if (notifications != null) notifications!,
      ];
}

final class AvatarInitial extends AvatarState {
  const AvatarInitial();
}

final class AvatarUserSubscription extends AvatarState {
  const AvatarUserSubscription({
    required super.imageUrl,
    required super.notifications,
  });
}

final class AvatarError extends AvatarState {
  const AvatarError();
}
