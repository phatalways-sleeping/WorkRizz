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

final class ProjectCloseCreateNewOne extends ProjectEvent {
  const ProjectCloseCreateNewOne();
}

final class ProjectRetrieveLatestSetup extends ProjectEvent {
  const ProjectRetrieveLatestSetup(this.context);

  final BuildContext context;
}
