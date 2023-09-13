part of 'thread_bloc.dart';

sealed class ThreadState extends Equatable {
  const ThreadState();
  
  @override
  List<Object> get props => [];
}

final class ThreadInitial extends ThreadState {
  const ThreadInitial();
}

final class ThreadLoading extends ThreadState {
  const ThreadLoading();
}

final class ThreadSuccess extends ThreadState {
  const ThreadSuccess();
}

final class ThreadFailure extends ThreadState {
  const ThreadFailure();
}