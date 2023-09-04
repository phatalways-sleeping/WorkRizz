import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/repositories/repositories.dart';
import 'package:uuid/v8.dart';

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
    on<ProjectCreateNewOne>((event, emit) {
      final newProjectSetup = Project(
        id: const UuidV8().generate(),
        name: "Demo project",
        tasks: const [],
        tags: const [],
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        leader: '',
        leaderImageUrl: '',
        assignees: const [],
        assigneeImageUrls: const [],
        mostActiveMemebers: const [],
        thread: const UuidV8().generate(),
      );

      emit(
        ProjectUserCreateAndSubscribe(
          username: state.username,
          onGoingProjectsNumber: state.onGoingProjectsNumber,
          leaderProjectsNumber: state.leaderProjectsNumber,
          completedProjectsNumber: state.completedProjectsNumber,
          projects: state.projects,
          filterStatus: (state as ProjectUserSubscription).filterStatus,
          newProjectSetup: newProjectSetup,
        ),
      );
    });
    on<ProjectCloseCreateNewOne>((event, emit) {
      emit(
        ProjectUserSubscription(
          username: state.username,
          onGoingProjectsNumber: state.onGoingProjectsNumber,
          leaderProjectsNumber: state.leaderProjectsNumber,
          completedProjectsNumber: state.completedProjectsNumber,
          projects: state.projects,
          filterStatus: (state as ProjectUserCreateAndSubscribe).filterStatus,
        ),
      );
    });
    on<ProjectRetrieveLatestSetup>((event, emit) async {
      final Project? latestSetup =
          await _applicationRepository.retrieveLatestProjectSetup();
      if (latestSetup != null) {
        emit(
          (state as ProjectUserCreateAndSubscribe).copyWith(
            newProjectSetup: latestSetup,
          ),
        );
      } else {
        event.context.scaffoldMessenger.showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 10.0,
            ),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            closeIconColor: event.context.colorScheme.onSecondary,
            backgroundColor: event.context.colorScheme.secondary,
            content: DefaultTextStyle.merge(
              style: event.context.textTheme.bodySmall,
              child: const Text(
                "You has not created one yet!",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
        );
      }
    });
    on<ProjectInputName>(
      (event, emit) => emit(
        (state as ProjectUserCreateAndSubscribe).copyWith(
          newProjectSetup:
              (state as ProjectUserCreateAndSubscribe).newProjectSetup.copyWith(
                    name: event.name.trim(),
                  ),
        ),
      ),
    );
    on<ProjectInputStartDate>(
      (event, emit) => emit(
        (state as ProjectUserCreateAndSubscribe).copyWith(
          newProjectSetup:
              (state as ProjectUserCreateAndSubscribe).newProjectSetup.copyWith(
                    startDate: event.date,
                  ),
        ),
      ),
    );
    on<ProjectInputEndDate>(
      (event, emit) => emit(
        (state as ProjectUserCreateAndSubscribe).copyWith(
          newProjectSetup:
              (state as ProjectUserCreateAndSubscribe).newProjectSetup.copyWith(
                    endDate: event.date,
                  ),
        ),
      ),
    );
    on<ProjectInputTag>(
      (event, emit) {
        final usedState = (state as ProjectUserCreateAndSubscribe);
        if (!usedState.newProjectSetup.tags.contains(event.tag)) {
          emit(
            usedState.copyWith(
              newProjectSetup: usedState.newProjectSetup.copyWith(
                tags: [
                  ...usedState.newProjectSetup.tags,
                  event.tag,
                ],
              ),
            ),
          );
        }
      },
    );
    on<ProjectInputAssignee>(
      (event, emit) async {
        final user =
            await _applicationRepository.userStreamByEmail(event.email);
        final usedState = (state as ProjectUserCreateAndSubscribe);
        if (!usedState.newProjectSetup.assignees.contains(user.id)) {
          emit(
            usedState.copyWith(
              newProjectSetup: usedState.newProjectSetup.copyWith(
                assigneeImageUrls: [
                  ...usedState.newProjectSetup.assigneeImageUrls,
                  user.imageUrl,
                ],
                assignees: [
                  ...usedState.newProjectSetup.assignees,
                  user.id,
                ],
              ),
            ),
          );
        }
      },
    );
    on<ProjectInputLeader>(
      (event, emit) async {
        final user =
            await _applicationRepository.userStreamByEmail(event.email);
        final usedState = (state as ProjectUserCreateAndSubscribe);
        if (usedState.newProjectSetup.leader != user.id) {
          emit(
            usedState.copyWith(
              newProjectSetup: usedState.newProjectSetup.copyWith(
                leaderImageUrl: user.imageUrl,
                leader: user.id,
              ),
            ),
          );
        }
      },
    );
    on<ProjectRequestToCreate>((event, emit) async {
      final project = (state as ProjectUserCreateAndSubscribe).newProjectSetup;

      if (project.name.isEmpty ||
          project.assignees.isEmpty ||
          project.leader.isEmpty ||
          project.tags.isEmpty) {
        event.context.scaffoldMessenger.showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 10.0,
            ),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            closeIconColor: event.context.colorScheme.onSecondary,
            backgroundColor: event.context.colorScheme.error,
            content: DefaultTextStyle.merge(
              style: event.context.textTheme.bodySmall,
              child: const Text(
                "Please complete all the field!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        );
      } else {
        emit(ProjectUserCreateAndSubscribeLoading.from(
            state as ProjectUserCreateAndSubscribe));
        await _applicationRepository
            .createNewProject(
              name: project.name,
              leader: project.leader,
              assignees: project.assignees,
              tagsName: project.tags.map((e) => e.title).toList(),
              startDate: project.startDate,
              endDate: project.endDate,
            )
            .then(
              (value) => emit(
                ProjectUserSubscription(
                  username: state.username,
                  onGoingProjectsNumber: state.onGoingProjectsNumber,
                  leaderProjectsNumber: state.leaderProjectsNumber,
                  completedProjectsNumber: state.completedProjectsNumber,
                  projects: state.projects,
                  filterStatus:
                      (state as ProjectUserCreateAndSubscribeLoading).filterStatus,
                ),
              ),
            );
      }
    });
  }

  Stream<Project> Function(String) get projectStream =>
      _applicationRepository.projectStream;

  String get userId => _applicationRepository.userId;

  Future<String> Function(String) get imageFuture =>
      _applicationRepository.imageUrlOnStorageOf;

  Future<List<NetworkImage>> assigneeAvatars() async {
    List<NetworkImage> list = List.empty(growable: true);
    for (var assignee in (state as ProjectUserCreateAndSubscribe)
        .newProjectSetup
        .assigneeImageUrls) {
      await imageFuture(assignee).then(
        (value) => list.add(
          NetworkImage(value),
        ),
      );
    }
    return list;
  }

  Future<NetworkImage> leaderAvatar() async {
    return imageFuture((state as ProjectUserCreateAndSubscribe)
            .newProjectSetup
            .leaderImageUrl)
        .then(
      (value) => NetworkImage(value),
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
