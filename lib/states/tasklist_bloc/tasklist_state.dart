part of 'tasklist_bloc.dart';

sealed class TasklistState extends Equatable {
  const TasklistState({
    this.project,
  });

  final Project? project;

  @override
  List<Object> get props => [
        if (project != null) project!,
      ];
}

final class TasklistInitial extends TasklistState {
  const TasklistInitial();
}

final class TasklistLoading extends TasklistState {
  const TasklistLoading({
    required super.project,
  });
}

final class TasklistSubscription extends TasklistState {
  const TasklistSubscription({
    required super.project,
  });
}

final class TasklistError extends TasklistState {
  const TasklistError();
}
