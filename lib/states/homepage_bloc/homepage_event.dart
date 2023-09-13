part of 'homepage_bloc.dart';

sealed class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

final class HomepageSubscribeToFirestore extends HomepageEvent {
  const HomepageSubscribeToFirestore();
}

final class HomepageMarkProjectAsCompleted extends HomepageEvent {
  const HomepageMarkProjectAsCompleted();
}

final class HomepageMarkProjectAsUncompleted extends HomepageEvent {
  const HomepageMarkProjectAsUncompleted();
}