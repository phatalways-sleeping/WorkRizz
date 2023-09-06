part of 'subtask_create_bloc.dart';

sealed class SubtaskCreateEvent extends Equatable {
  const SubtaskCreateEvent();

  @override
  List<Object> get props => [];
}

final class SubTaskCreateSubscribeToTaskEvent extends SubtaskCreateEvent {
  const SubTaskCreateSubscribeToTaskEvent();
}

final class SubTaskRemoveCurrentEvent extends SubtaskCreateEvent {
  const SubTaskRemoveCurrentEvent();
}


final class SubTaskRequestToCreateEvent extends SubtaskCreateEvent {
  const SubTaskRequestToCreateEvent();
}

final class SubTaskInputNameEvent extends SubtaskCreateEvent {
  const SubTaskInputNameEvent(this.name);

  final String name;

  @override
  List<Object> get props => [...super.props, name];
}

final class SubTaskInputDescriptionEvent extends SubtaskCreateEvent {
  const SubTaskInputDescriptionEvent(this.description);

  final String description;

  @override
  List<Object> get props => [...super.props, description];
}

final class SubTaskInputDueDateEvent extends SubtaskCreateEvent {
  const SubTaskInputDueDateEvent(this.dueDate);

  final DateTime dueDate;

  @override
  List<Object> get props => [...super.props, dueDate];
}

final class SubTaskInputAssignedToEvent extends SubtaskCreateEvent {
  const SubTaskInputAssignedToEvent(this.email);

  final String email;

  @override
  List<Object> get props => [...super.props, email];
}

final class SubTaskInputPointsEvent extends SubtaskCreateEvent {
  const SubTaskInputPointsEvent(this.points);

  final int points;

  @override
  List<Object> get props => [...super.props, points];
}

final class SubTaskInputAttachmentsEvent extends SubtaskCreateEvent {
  const SubTaskInputAttachmentsEvent(this.attachments);

  final List<File> attachments;

  @override
  List<Object> get props => [...super.props, attachments];
}

final class SubTaskDownloadAttachmentEvent extends SubtaskCreateEvent {
  const SubTaskDownloadAttachmentEvent(this.attachment);

  final File attachment;

  @override
  List<Object> get props => [...super.props, attachment];
}