part of 'tasklist_bloc.dart';

sealed class TasklistState extends Equatable {
  const TasklistState({
    this.project,
    this.currentPage = 0,
  });

  final Project? project;
  final int currentPage;

  @override
  List<Object> get props => [
        if (project != null) project!,
        currentPage,
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
    super.currentPage = 0,
  });

  TasklistSubscription copyWith({
    Project? project,
    int? currentPage,
  }) {
    return TasklistSubscription(
      project: project ?? this.project,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

final class TasklistError extends TasklistState {
  const TasklistError();
}
