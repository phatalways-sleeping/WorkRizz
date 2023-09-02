part of 'project_bloc.dart';

sealed class ProjectState extends Equatable {
  const ProjectState({
    this.username,
    this.leaderProjectsNumber,
    this.completedProjectsNumber,
    this.onGoingProjectsNumber,
    this.projects,
  });

  final String? username;
  final int? leaderProjectsNumber;
  final int? onGoingProjectsNumber;
  final int? completedProjectsNumber;
  final List<String>? projects;

  @override
  List<Object> get props => [
        if (username != null) username!,
        if (leaderProjectsNumber != null) leaderProjectsNumber!,
        if (onGoingProjectsNumber != null) onGoingProjectsNumber!,
        if (completedProjectsNumber != null) completedProjectsNumber!,
        if (projects != null) projects!,
      ];
}

final class ProjectInitial extends ProjectState {
  const ProjectInitial();
}

final class ProjectUserSubscription extends ProjectState {
  const ProjectUserSubscription({
    required super.username,
    required super.onGoingProjectsNumber,
    required super.leaderProjectsNumber,
    required super.completedProjectsNumber,
    required super.projects,
    required this.filterStatus,
  });

  final FilterStatus filterStatus;

  @override
  List<Object> get props => [
        ...super.props,
        filterStatus,
      ];

  ProjectUserSubscription copyWith({
    String? username,
    int? leaderProjectsNumber,
    int? onGoingProjectsNumber,
    int? completedProjectsNumber,
    List<String>? projects,
    FilterStatus? filterStatus,
  }) =>
      ProjectUserSubscription(
        username: username ?? this.username,
        onGoingProjectsNumber:
            onGoingProjectsNumber ?? this.onGoingProjectsNumber,
        leaderProjectsNumber: leaderProjectsNumber ?? this.leaderProjectsNumber,
        completedProjectsNumber:
            completedProjectsNumber ?? this.completedProjectsNumber,
        projects: projects ?? this.projects,
        filterStatus: filterStatus ?? this.filterStatus,
      );
}

final class ProjectError extends ProjectState {
  const ProjectError();
}
