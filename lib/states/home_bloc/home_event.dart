part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeSubscribeEvent extends HomeEvent {
  const HomeSubscribeEvent();
}

final class HomeMarkSubTaskCompleteEvent extends HomeEvent {
  const HomeMarkSubTaskCompleteEvent({
    required this.subTaskId,
  });

  final String subTaskId;

  @override
  List<Object> get props => [
        ...super.props,
        subTaskId,
      ];
}
