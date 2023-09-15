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

  factory TasklistSubscription.from(
          TasklistSubscriptionAndOpenTaskCreateDialog state) =>
      TasklistSubscription(
        project: state.project,
        currentPage: state.currentPage,
      );

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

final class TasklistSubscriptionEditable extends TasklistSubscription {
  const TasklistSubscriptionEditable({
    required super.project,
    super.currentPage = 0,
  });

  factory TasklistSubscriptionEditable.from(TasklistSubscription state) =>
      TasklistSubscriptionEditable(
        project: state.project,
        currentPage: state.currentPage,
      );

  @override
  TasklistSubscriptionEditable copyWith({
    Project? project,
    int? currentPage,
  }) {
    return TasklistSubscriptionEditable(
      project: project ?? this.project,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

final class TasklistSubscriptionLoading extends TasklistSubscription {
  const TasklistSubscriptionLoading({
    required super.project,
    super.currentPage = 0,
    this.isEditing = false,
  });

  final bool isEditing;

  factory TasklistSubscriptionLoading.from(
    TasklistSubscription state, {
    bool? isEditing,
  }) =>
      TasklistSubscriptionLoading(
        project: state.project,
        currentPage: state.currentPage,
        isEditing: isEditing ?? false,
      );

  @override
  TasklistSubscriptionLoading copyWith({
    Project? project,
    int? currentPage,
    bool? isEditing,
  }) {
    return TasklistSubscriptionLoading(
      project: project ?? this.project,
      currentPage: currentPage ?? this.currentPage,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  @override
  List<Object> get props => [
        ...super.props,
        isEditing,
      ];
}

final class TasklistSubscriptionAndOpenTaskCreateDialog
    extends TasklistSubscription {
  const TasklistSubscriptionAndOpenTaskCreateDialog({
    required super.project,
    required super.currentPage,
  });

  factory TasklistSubscriptionAndOpenTaskCreateDialog.from(
          TasklistSubscription state) =>
      TasklistSubscriptionAndOpenTaskCreateDialog(
        project: state.project,
        currentPage: state.currentPage,
      );

  @override
  TasklistSubscriptionAndOpenTaskCreateDialog copyWith({
    Project? project,
    int? currentPage,
  }) {
    return TasklistSubscriptionAndOpenTaskCreateDialog(
      project: project ?? this.project,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

final class TasklistDeleteProjectState extends TasklistState {
  const TasklistDeleteProjectState({
    super.project,
    super.currentPage = 0,
  });
}

final class TasklistError extends TasklistState {
  const TasklistError(this.message);

  final String message;

  @override
  List<Object> get props => [
        message,
      ];
}
