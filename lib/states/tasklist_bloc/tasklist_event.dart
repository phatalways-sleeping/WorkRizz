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

final class TasklistChangePage extends TasklistEvent {
  const TasklistChangePage({
    required this.page,
  });

  final int page;

  @override
  List<Object> get props => [
        page,
      ];
}

final class TasklistMarkSubTaskAsCompleted extends TasklistEvent {
  const TasklistMarkSubTaskAsCompleted({
    required this.taskId,
    required this.subTaskId,
    required this.assigneeImageUrl,
  });

  final String taskId;
  final String subTaskId;
  final String assigneeImageUrl;

  @override
  List<Object> get props => [
        taskId,
        subTaskId,
        assigneeImageUrl,
      ];
}

final class TasklistMarkSubTaskAsUncompleted extends TasklistEvent {
  const TasklistMarkSubTaskAsUncompleted({
    required this.taskId,
    required this.subTaskId,
    required this.assigneeImageUrl,
  });

  final String taskId;
  final String subTaskId;
  final String assigneeImageUrl;

  @override
  List<Object> get props => [
        taskId,
        subTaskId,
        assigneeImageUrl,
      ];
}

final class TasklistCreateNewTask extends TasklistEvent {
  const TasklistCreateNewTask(this.name);

  final String? name;

  @override
  List<Object> get props => [
        if(name != null) name!,
      ];
}

final class TasklistOpenTaskCreateDialog extends TasklistEvent {
  const TasklistOpenTaskCreateDialog();
}