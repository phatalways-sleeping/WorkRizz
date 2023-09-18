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

final class TasklistRequestEditProject extends TasklistEvent {
  const TasklistRequestEditProject();
}

final class TasklistCancelEditProject extends TasklistEvent {
  const TasklistCancelEditProject();
}

final class TasklistAddNewAssignee extends TasklistEvent {
  const TasklistAddNewAssignee({
    required this.assignee,
  });

  final String assignee;

  @override
  List<Object> get props => [
        assignee,
      ];
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
        if (name != null) name!,
      ];
}

final class TasklistOpenTaskCreateDialog extends TasklistEvent {
  const TasklistOpenTaskCreateDialog();
}

final class TasklistDeleteTask extends TasklistEvent {
  const TasklistDeleteTask(this.taskId);

  final String taskId;

  @override
  List<Object> get props => [
        taskId,
      ];
}

final class TasklistDeleteSubTask extends TasklistEvent {
  const TasklistDeleteSubTask({
    required this.taskId,
    required this.subTaskId,
  });

  final String taskId;
  final String subTaskId;

  @override
  List<Object> get props => [
        taskId,
        subTaskId,
      ];
}

final class TasklistDeleteProject extends TasklistEvent {
  const TasklistDeleteProject();
}