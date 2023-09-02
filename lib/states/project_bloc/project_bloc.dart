import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_managing_application/repositories/repositories.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc(this._applicationRepository) : super(const ProjectInitial()) {
    on<ProjectSubscribeToUserEvent>(
      (event, emit) async {
        await emit.forEach(
          _applicationRepository.userStream(_applicationRepository.userId),
          onData: (user) => ProjectUserSubscription(
            username: user.username,
            leaderProjectsNumber: user.leaderProjects,
            onGoingProjectsNumber: user.onGoingProjects,
            completedProjectsNumber: user.completedProjects,
            projects: user.projects,
            filterStatus: (state is ProjectInitial || state is ProjectError)
                ? FilterStatus.none
                : (state as ProjectUserSubscription).filterStatus,
          ),
          onError: (error, stackTrace) => const ProjectError(),
        );
      },
    );
    on<ProjectFilterEvent>(
      (event, emit) => emit(
        (state as ProjectUserSubscription).copyWith(
          filterStatus: event.filterStatus,
        ),
      ),
    );
  }

  final ApplicationRepository _applicationRepository;
}

enum FilterStatus {
  leader,
  ongoing,
  completed,
  none,
}
