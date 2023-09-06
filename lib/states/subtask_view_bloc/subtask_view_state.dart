part of 'subtask_view_bloc.dart';

sealed class SubtaskViewState extends Equatable {
  const SubtaskViewState();

  @override
  List<Object> get props => [];
}

final class SubtaskViewInitial extends SubtaskViewState {
  const SubtaskViewInitial();
}

final class SubtaskViewLoading extends SubtaskViewState {
  const SubtaskViewLoading();
}

final class SubtaskViewSuccess extends SubtaskViewState {
  const SubtaskViewSuccess({
    required this.name,
    required this.description,
    required this.assignee,
    required this.dueDate,
    required this.isCompleted,
    required this.points,
    required this.files,
    required this.comments,
    required this.progress,
    required this.grade,
    required this.leaderComment,
  });

  factory SubtaskViewSuccess.from(SubTaskViewSuccessRequestComment state) =>
      SubtaskViewSuccess(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
      );

  final String name;
  final String description;
  final String assignee;
  final DateTime dueDate;
  final bool isCompleted;
  final int points;
  final List<String> files;
  final List<String> comments;
  final double progress;
  final int grade;
  final String leaderComment;

  @override
  List<Object> get props => [
        ...super.props,
        name,
        description,
        assignee,
        dueDate,
        isCompleted,
        points,
        files,
        comments,
        progress,
        grade,
        leaderComment,
      ];

  SubtaskViewSuccess copyWith({
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<String>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
  }) {
    return SubtaskViewSuccess(
      name: name ?? this.name,
      description: description ?? this.description,
      assignee: assignee ?? this.assignee,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      points: points ?? this.points,
      files: files ?? this.files,
      comments: comments ?? this.comments,
      progress: progress ?? this.progress,
      grade: grade ?? this.grade,
      leaderComment: leaderComment ?? this.leaderComment,
    );
  }
}

final class SubTaskViewSuccessRequestComment extends SubtaskViewSuccess {
  const SubTaskViewSuccessRequestComment({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
  });

  factory SubTaskViewSuccessRequestComment.from(SubtaskViewSuccess state) =>
      SubTaskViewSuccessRequestComment(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
      );

  @override
  SubTaskViewSuccessRequestComment copyWith(
      {String? name,
      String? description,
      String? assignee,
      DateTime? dueDate,
      bool? isCompleted,
      int? points,
      List<String>? files,
      List<String>? comments,
      double? progress,
      int? grade,
      String? leaderComment}) {
    return SubTaskViewSuccessRequestComment(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
    );
  }
}

final class SubTaskViewSuccessRequestReplyComment
    extends SubTaskViewSuccessRequestComment {
  const SubTaskViewSuccessRequestReplyComment({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
    required this.replyUsername,
  });

  factory SubTaskViewSuccessRequestReplyComment.from(
    SubtaskViewSuccess state,
    String replyUsername,
  ) =>
      SubTaskViewSuccessRequestReplyComment(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
        replyUsername: replyUsername,
      );

  final String replyUsername;

  @override
  List<Object> get props => [...super.props, replyUsername];

  @override
  SubTaskViewSuccessRequestReplyComment copyWith({
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<String>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
    String? replyUsername,
  }) {
    return SubTaskViewSuccessRequestReplyComment(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
      replyUsername: replyUsername ?? this.replyUsername,
    );
  }
}

abstract class SubtaskViewFailure extends SubtaskViewState {
  const SubtaskViewFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class SubtaskViewFailureDueToNetwork extends SubtaskViewFailure {
  const SubtaskViewFailureDueToNetwork(super.error);
}

final class SubtaskViewFailureDueToDataIntegrity extends SubtaskViewFailure {
  const SubtaskViewFailureDueToDataIntegrity(super.error);
}
