part of 'subtask_view_bloc.dart';

sealed class SubtaskViewEvent extends Equatable {
  const SubtaskViewEvent();

  @override
  List<Object> get props => [];
}

final class SubTaskSubscribeEvent extends SubtaskViewEvent {
  const SubTaskSubscribeEvent();
}

final class SubTaskInputDueDateEvent extends SubtaskViewEvent {
  const SubTaskInputDueDateEvent(this.dueDate);

  final DateTime dueDate;

  @override
  List<Object> get props => [...super.props, dueDate];
}

final class SubTaskInputPointsEvent extends SubtaskViewEvent {
  const SubTaskInputPointsEvent(this.points);

  final int points;

  @override
  List<Object> get props => [...super.props, points];
}

final class SubTaskInputDescriptionEvent extends SubtaskViewEvent {
  const SubTaskInputDescriptionEvent(this.description);

  final String description;

  @override
  List<Object> get props => [...super.props, description];
}


final class SubTaskInputGradeEvent extends SubtaskViewEvent {
  const SubTaskInputGradeEvent(this.grade);

  final int grade;

  @override
  List<Object> get props => [...super.props, grade];
}

final class SubTaskMarkSubTaskCompletedEvent extends SubtaskViewEvent {
  const SubTaskMarkSubTaskCompletedEvent();
}

final class SubTaskMarkSubTaskUncompletedEvent extends SubtaskViewEvent {
  const SubTaskMarkSubTaskUncompletedEvent();
}

final class SubTaskInputProgressEvent extends SubtaskViewEvent {
  const SubTaskInputProgressEvent(this.progress);

  final double progress;

  @override
  List<Object> get props => [...super.props, progress];
}

final class SubTaskInputLeaderCommentEvent extends SubtaskViewEvent {
  const SubTaskInputLeaderCommentEvent(this.comment);

  final String comment;

  @override
  List<Object> get props => [...super.props, comment];
}

final class SubTaskConfirmChangePermissionsEvent
    extends SubtaskViewEvent {
  const SubTaskConfirmChangePermissionsEvent();

  @override
  List<Object> get props => [...super.props];
}

final class SubTaskCancelChangePermissionsEvent
    extends SubtaskViewEvent {
  const SubTaskCancelChangePermissionsEvent();

  @override
  List<Object> get props => [...super.props];
}

final class SubTaskInputAttachmentEvent extends SubtaskViewEvent {
  const SubTaskInputAttachmentEvent();
}

final class SubTaskAcceptOverrideAttachments extends SubtaskViewEvent {
  const SubTaskAcceptOverrideAttachments(this.files);

  final List<File> files;

  @override
  List<Object> get props => [...super.props, files];
}

final class SubTaskRejectOverrideAttachments extends SubtaskViewEvent {
  const SubTaskRejectOverrideAttachments(this.files);

  final List<File> files;

  @override
  List<Object> get props => [...super.props, files];
}

final class SubTaskDeleteAttachmentEvent extends SubtaskViewEvent {
  const SubTaskDeleteAttachmentEvent(this.attachment);

  final String attachment;

  @override
  List<Object> get props => [...super.props, attachment];
}

final class SubTaskDownloadAttachmentEvent extends SubtaskViewEvent {
  const SubTaskDownloadAttachmentEvent(this.attachment);

  final String attachment;

  @override
  List<Object> get props => [...super.props, attachment];
}

final class SubTaskRequestInputSubTaskCommentEvent extends SubtaskViewEvent {
  const SubTaskRequestInputSubTaskCommentEvent();

  @override
  List<Object> get props => [...super.props];
}

final class SubTaskCancelRequestInputSubTaskCommentEvent
    extends SubtaskViewEvent {
  const SubTaskCancelRequestInputSubTaskCommentEvent();

  @override
  List<Object> get props => [...super.props];
}

final class SubTaskInputSubTaskCommentEvent extends SubtaskViewEvent {
  const SubTaskInputSubTaskCommentEvent(this.comment);

  final String comment;

  @override
  List<Object> get props => [...super.props, comment];
}

final class SubTaskRemoveSubTaskCommentEvent extends SubtaskViewEvent {
  const SubTaskRemoveSubTaskCommentEvent(this.commentId);

  final String commentId;

  @override
  List<Object> get props => [...super.props, commentId];
}

final class SubTaskRequestReplyToCommentEvent extends SubtaskViewEvent {
  const SubTaskRequestReplyToCommentEvent({
    required this.replyToUsername,
    required this.commentId,
  });

  final String replyToUsername;
  final String commentId;

  @override
  List<Object> get props => [...super.props, replyToUsername, commentId];
}

final class SubTaskReplyToCommentEvent extends SubtaskViewEvent {
  const SubTaskReplyToCommentEvent({
    required this.comment,
  });

  final String comment;

  @override
  List<Object> get props => [...super.props, comment];
}

final class SubTaskMarkCommentSolvedEvent extends SubtaskViewEvent {
  const SubTaskMarkCommentSolvedEvent(this.commentId);

  final String commentId;

  @override
  List<Object> get props => [...super.props, commentId];
}

final class SubTaskMarkCommentUnsolvedEvent extends SubtaskViewEvent {
  const SubTaskMarkCommentUnsolvedEvent(this.commentId);

  final String commentId;

  @override
  List<Object> get props => [...super.props, commentId];
}
