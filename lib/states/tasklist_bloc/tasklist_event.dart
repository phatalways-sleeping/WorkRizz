part of 'tasklist_bloc.dart';

sealed class TasklistEvent extends Equatable {
  const TasklistEvent();

  @override
  List<Object> get props => [];
}

final class TasklistSubscribeToFirestore extends TasklistEvent {
  const TasklistSubscribeToFirestore();
}

final class TasklistMarkProjectAsCompleted extends TasklistEvent {
  const TasklistMarkProjectAsCompleted();
}

final class TasklistMarkProjectAsUncompleted extends TasklistEvent {
  const TasklistMarkProjectAsUncompleted();
}