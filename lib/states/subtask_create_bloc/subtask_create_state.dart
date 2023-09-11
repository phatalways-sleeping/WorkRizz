part of 'subtask_create_bloc.dart';

sealed class SubtaskCreateState extends Equatable {
  const SubtaskCreateState();

  @override
  List<Object> get props => [];
}

final class SubtaskCreateInitial extends SubtaskCreateState {
  const SubtaskCreateInitial();
}

final class SubtaskCreateLoading extends SubtaskCreateState {
  const SubtaskCreateLoading();
}

final class SubtaskCreateSuccess extends SubtaskCreateState {
  const SubtaskCreateSuccess({
    required this.projectMembers,
    required this.projectDueDate,
    required this.projectName,
    this.subTaskName,
    this.dueDate,
    this.description,
    this.assignedTo,
    this.points,
    this.attachments,
  });

  final List<String> projectMembers;
  final DateTime projectDueDate;
  final String projectName;
  final String? subTaskName;
  final DateTime? dueDate;
  final String? description;
  final String? assignedTo;
  final int? points;
  final List<File>? attachments;

  @override
  List<Object> get props => [
        ...super.props,
        projectMembers,
        projectDueDate,
        projectName,
        if (subTaskName != null) subTaskName!,
        if (dueDate != null) dueDate!,
        if (description != null) description!,
        if (assignedTo != null) assignedTo!,
        if (points != null) points!,
        if (attachments != null) attachments!,
      ];

  SubtaskCreateSuccess copyWith({
    List<String>? projectMembers,
    DateTime? projectDueDate,
    String? projectName,
    String? subTaskName,
    DateTime? dueDate,
    String? description,
    String? assignedTo,
    int? points,
    List<File>? attachments,
  }) {
    return SubtaskCreateSuccess(
      projectMembers: projectMembers ?? this.projectMembers,
      projectDueDate: projectDueDate ?? this.projectDueDate,
      projectName: projectName ?? this.projectName,
      subTaskName: subTaskName ?? this.subTaskName,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      assignedTo: assignedTo ?? this.assignedTo,
      points: points ?? this.points,
      attachments: attachments ?? this.attachments,
    );
  }
}

final class SubTaskCreateFailureDueToDataIntegrity extends SubtaskCreateState {
  const SubTaskCreateFailureDueToDataIntegrity({
    required this.error,
  });

  final String error;

  @override
  List<Object> get props => [
        ...super.props,
        error,
      ];
}

final class SubtaskCreateFailureDueToNetwork extends SubtaskCreateState {
  const SubtaskCreateFailureDueToNetwork({
    required this.error,
  });

  final String error;

  @override
  List<Object> get props => [
        ...super.props,
        error,
      ];
}
