part of 'thread_bloc.dart';

sealed class ThreadEvent extends Equatable {
  const ThreadEvent();

  @override
  List<Object> get props => [];
}

final class ThreadSubscribeEvent extends ThreadEvent {
  const ThreadSubscribeEvent();
}