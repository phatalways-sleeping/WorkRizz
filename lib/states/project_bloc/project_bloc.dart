// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';
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
    on<ProjectCreateNewOne>((event, emit) async {
      final newProjectSetup =
          _applicationRepository.createDefaultProjectSetup();

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
    on<ProjectRequestCloseNewOne>((event, emit) {
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
    on<ProjectCloseCreateNewOne>((event, emit) {
      emit(
        ProjectUserSubscription(
          username: state.username,
          onGoingProjectsNumber: state.onGoingProjectsNumber,
          leaderProjectsNumber: state.leaderProjectsNumber,
          completedProjectsNumber: state.completedProjectsNumber,
          projects: state.projects,
          filterStatus: FilterStatus.none,
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
            padding: EdgeInsets.symmetric(
              horizontal:
                  event.context.mediaQuery.size.width * RATIO_PADDING * 1.2,
              vertical: event.context.mediaQuery.size.height * RATIO_PADDING,
            ),
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
            backgroundColor: event.context.colorScheme.onSecondary,
            content: DefaultTextStyle.merge(
              style: event.context.textTheme.bodySmall,
              child: const Text(
                "You has not created one yet!",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
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
        // get user by email
        UserDataModel user =
            await _applicationRepository.userStreamByEmail(event.email).first;
        user = await _applicationRepository.userStream(user.id).first;

        

        final usedState = (state as ProjectUserCreateAndSubscribe);
        // check if user is already in assignees
        if (!usedState.newProjectSetup.assignees.contains(user.id)) {
          // check if user is already the leader
          if (usedState.newProjectSetup.leader == user.id) {
            // show snackbar if user is already the leader
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
                    "This user is already the leader!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            );
          } else {
            // add user to assignees
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
        }
      },
    );
    on<ProjectInputLeader>(
      (event, emit) async {
        // get user by email
        final user =
            await _applicationRepository.userStreamByEmail(event.email).first;
        final usedState = (state as ProjectUserCreateAndSubscribe);
        // check if user is already the leader
        if (usedState.newProjectSetup.leader != user.id) {
          // check if user is already in assignees
          final newAssignees = usedState.newProjectSetup.assignees
              .where((element) => element != user.id)
              .toList();
          // check if user imageUrl is already in assigneeImageUrls
          final newAssigneeImageUrls = usedState
              .newProjectSetup.assigneeImageUrls
              .where((element) => element != user.imageUrl)
              .toList();
          // check if the owner account is leader
          if (usedState.newProjectSetup.leader ==
              _applicationRepository.userId) {
            newAssignees.add(usedState.newProjectSetup.leader);
            newAssigneeImageUrls.add(usedState.newProjectSetup.leaderImageUrl);
          }
          emit(
            usedState.copyWith(
              newProjectSetup: usedState.newProjectSetup.copyWith(
                leaderImageUrl: user.imageUrl,
                leader: user.id,
                assignees: newAssignees,
                assigneeImageUrls: newAssigneeImageUrls,
              ),
            ),
          );
        }
      },
    );
    on<ProjectRequestToCreate>(
      (event, emit) async {
        final project =
            (state as ProjectUserCreateAndSubscribe).newProjectSetup;

        if (project.name.isEmpty ||
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
        } else if (project.endDate.difference(project.startDate).inDays < 0) {
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
                  "Invalid end date!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          );
        } else {
          emit(
            ProjectUserCreateAndSubscribeLoading.from(
              state as ProjectUserCreateAndSubscribe,
            ),
          );
          await _applicationRepository.createNewProject(
            newSetupProject:
                (state as ProjectUserCreateAndSubscribeLoading).newProjectSetup,
          );
        }
      },
    );
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
