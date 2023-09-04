part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

final class ProjectSubscribeToUserEvent extends ProjectEvent {
  const ProjectSubscribeToUserEvent();
}

final class ProjectFilterEvent extends ProjectEvent {
  const ProjectFilterEvent(this.filterStatus);

  final FilterStatus filterStatus;
  @override
  List<Object> get props => [
        ...super.props,
        filterStatus,
      ];
}

final class ProjectCreateNewOne extends ProjectEvent {
  const ProjectCreateNewOne();
}

final class ProjectRequestCloseNewOne extends ProjectEvent {
  const ProjectRequestCloseNewOne();
}

final class ProjectCloseCreateNewOne extends ProjectEvent {
  const ProjectCloseCreateNewOne();
}

final class ProjectRetrieveLatestSetup extends ProjectEvent {
  const ProjectRetrieveLatestSetup(this.context);

  final BuildContext context;
}

final class ProjectInputName extends ProjectEvent {
  const ProjectInputName(this.name);

  final String name;

  @override
  List<Object> get props => [...super.props, name];
}

final class ProjectInputStartDate extends ProjectEvent {
  const ProjectInputStartDate(this.date);

  final DateTime date;

  @override
  List<Object> get props => [...super.props, date];
}

final class ProjectInputEndDate extends ProjectEvent {
  const ProjectInputEndDate(this.date);

  final DateTime date;

  @override
  List<Object> get props => [...super.props, date];
}

final class ProjectInputTag extends ProjectEvent {
  const ProjectInputTag(this.tag);
  final Tag tag;

  @override
  List<Object> get props => [...super.props, tag];
}

final class ProjectInputAssignee extends ProjectEvent {
  const ProjectInputAssignee(this.email, this.context);

  final String email;
  final BuildContext context;

  @override
  List<Object> get props => [...super.props, email, context];
}

final class ProjectInputLeader extends ProjectEvent {
  const ProjectInputLeader(this.email);

  final String email;

  @override
  List<Object> get props => [...super.props, email];
}

final class ProjectRequestToCreate extends ProjectEvent {
  const ProjectRequestToCreate(this.context);

  final BuildContext context;
}
