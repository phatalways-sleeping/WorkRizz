part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeSuccess extends HomeState {
  const HomeSuccess({
    required this.subTaskIds,
    required this.username,
  });

  final List<String> subTaskIds;
  final String username;

  @override
  List<Object> get props => [
        ...super.props,
        subTaskIds,
        username,
      ];
}

final class HomeError extends HomeState {
  const HomeError();
}
