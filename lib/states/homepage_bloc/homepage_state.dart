part of 'homepage_bloc.dart';

sealed class HomepageState extends Equatable {
  const HomepageState({
    this.project,
  });

  final Project? project;

  @override
  List<Object> get props => [
        if (project != null) project!,
      ];
}

final class HomepageInitial extends HomepageState {
  const HomepageInitial();
}

final class HomepageLoading extends HomepageState {
  const HomepageLoading({
    required super.project,
  });
}

final class HomepageSubscription extends HomepageState {
  const HomepageSubscription({
    required super.project,
  });
}

final class HomepageError extends HomepageState {
  const HomepageError();
}
