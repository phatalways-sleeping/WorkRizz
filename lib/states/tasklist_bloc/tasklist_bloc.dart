import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/repositories/repositories.dart';
part 'tasklist_event.dart';
part 'tasklist_state.dart';

class TasklistBloc extends Bloc<TasklistEvent, TasklistState> {
  TasklistBloc(this._applicationRepository) : super(const TasklistInitial()) {
    on<TasklistSubscribeToFirestore>((event, emit) async {
      await emit.forEach(
        _applicationRepository.projectOnViewStream(),
        onData: streamTransformation,
        onError: (error, stackTrace) => TasklistError(error.toString()),
      );
    });
    on<TasklistMarkProjectAsCompleted>((event, emit) async {
      await _applicationRepository.markProjectCompleted(
        (state as TasklistSubscription).project!.id,
        (state as TasklistSubscription).project!.assignees,
        (state as TasklistSubscription).project!.leader,
      );
    });
    on<TasklistMarkProjectAsUncompleted>((event, emit) async {
      await _applicationRepository.markProjectIncompleted(
        (state as TasklistSubscription).project!.id,
        (state as TasklistSubscription).project!.assignees,
        (state as TasklistSubscription).project!.leader,
      );
    });
    on<TasklistAddNewAssignee>((event, emit) async {
      await _applicationRepository.addNewAssigneeToProject(
        event.assignee,
      );
    });
    on<TasklistRequestEditProject>((event, emit) async {
      emit(TasklistSubscriptionEditable.from(state as TasklistSubscription));
    });
    on<TasklistCancelEditProject>((event, emit) async {
      emit(TasklistSubscription(
        project: state.project,
        currentPage: state.currentPage,
      ));
    });
    on<TasklistDeleteSubTask>((event, emit) async {
      emit(TasklistSubscriptionLoading.from(
        state as TasklistSubscription,
        isEditing: true,
      ));
      await _applicationRepository.deleteSubTask(
        // taskId: event.taskId,
        subTaskId: event.subTaskId,
      );
    });
    on<TasklistDeleteTask>((event, emit) async {
      emit(TasklistSubscriptionLoading.from(
        (state as TasklistSubscription).copyWith(
          currentPage: state.currentPage - 1,
        ),
        isEditing: true,
      ));
      await _applicationRepository.deleteTask(
        taskId: event.taskId,
      );
    });
    on<TasklistDeleteProject>((event, emit) async {
      final projectId = (state as TasklistSubscription).project!.id;
      emit(const TasklistDeleteProjectState());
      await _applicationRepository.deleteProject(
        projectId: projectId,
      );
    });
    on<TasklistChangePage>((event, emit) async {
      emit((state as TasklistSubscription).copyWith(currentPage: event.page));
    });
    on<TasklistMarkSubTaskAsCompleted>((event, emit) async {
      emit(TasklistSubscriptionLoading.from(state as TasklistSubscription));
      await _applicationRepository.markSubTaskCompleted(
        taskId: event.taskId,
        subTaskId: event.subTaskId,
      );
    });
    on<TasklistMarkSubTaskAsUncompleted>((event, emit) async {
      emit(
        TasklistSubscriptionLoading.from((state as TasklistSubscription)),
      );
      await _applicationRepository.markSubTaskUnCompleted(
        taskId: event.taskId,
        subTaskId: event.subTaskId,
      );
    });
    on<TasklistCreateNewTask>((event, emit) async {
      if (event.name == null) {
        emit(
          TasklistSubscription.from(
            state as TasklistSubscriptionAndOpenTaskCreateDialog,
          ),
        );
        return;
      }
      if (event.name!.isEmpty) {
        emit(
          TasklistSubscription.from(
            state as TasklistSubscriptionAndOpenTaskCreateDialog,
          ),
        );
        return;
      }
      await _applicationRepository.createNewTask(
        name: event.name!,
      );
    });
    on<TasklistOpenTaskCreateDialog>((event, emit) async {
      emit(TasklistSubscriptionAndOpenTaskCreateDialog.from(
          state as TasklistSubscription));
    });
  }

  TasklistState streamTransformation(Project project) {
    project.taskSmallInformations.sort((a, b) => a.name.compareTo(b.name));
    for (var element in project.taskSmallInformations) {
      element.subTaskSmallInformations.sort((a, b) => a.name.compareTo(b.name));
    }
    if (state is TasklistSubscriptionLoading) {
      if ((state as TasklistSubscriptionLoading).isEditing) {
        return TasklistSubscriptionEditable(
          project: project,
          currentPage: (state as TasklistSubscriptionLoading).currentPage,
        );
      }
      return TasklistSubscription(
        project: project,
        currentPage: (state as TasklistSubscriptionLoading).currentPage,
      );
    }
    if (state is TasklistSubscriptionEditable) {
      return TasklistSubscriptionEditable(
        project: project,
        currentPage: state.currentPage,
      );
    }
    if (state is TasklistDeleteProjectState) {
      return const TasklistDeleteProjectState();
    }
    return TasklistSubscription(
      project: project,
      currentPage: (state is TasklistSubscriptionAndOpenTaskCreateDialog &&
              state.currentPage < 0)
          ? 0
          : state.currentPage,
    );
  }

  final ApplicationRepository _applicationRepository;

  Future<String> imageUrl(String path) async =>
      _applicationRepository.imageUrlOnStorageOf(path);

  Future<List<NetworkImage>> assigneeAvatars() async {
    List<NetworkImage> list = List.empty(growable: true);
    for (var assignee
        in (state as TasklistSubscription).project!.assigneeImageUrls) {
      await imageUrl(assignee).then(
        (value) => list.add(
          NetworkImage(value),
        ),
      );
    }
    return list;
  }

  Future<List<NetworkImage>> mostActiveMembers() async {
    List<String> list = List.empty(growable: true);
    List<NetworkImage> imageList = List.empty(growable: true);
    for (var member
        in (state as TasklistSubscription).project!.mostActiveMemebers) {
      await _applicationRepository.userStream(member).first.then(
            (value) => list.add(
              value.imageUrl,
            ),
          );
    }
    for (var imageUrl in list) {
      await this.imageUrl(imageUrl).then(
            (value) => imageList.add(
              NetworkImage(value),
            ),
          );
    }
    return imageList;
  }
}
