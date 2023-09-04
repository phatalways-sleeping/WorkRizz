part of 'project_item_bloc.dart';

sealed class ProjectItemEvent extends Equatable {
  const ProjectItemEvent();

  @override
  List<Object> get props => [];
}

final class ProjectItemSubscribeToProjectEvent extends ProjectItemEvent {
  const ProjectItemSubscribeToProjectEvent(this.projectId);

  final String projectId;
}

final class ProjectItemFilterEvent extends ProjectItemEvent {
  const ProjectItemFilterEvent(this.filterStatus);
  final FilterStatus filterStatus;

  @override
  List<Object> get props => [...super.props, filterStatus];
}
