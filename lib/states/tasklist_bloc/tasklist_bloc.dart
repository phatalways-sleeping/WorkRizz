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
      emit(TasklistSubscriptionLoading.from(state as TasklistSubscription));
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
      if(event.name!.isEmpty) {
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
    project.taskSmallInformations
        .sort((a, b) => a.name.compareTo(b.name));
    if (state is TasklistSubscriptionLoading) {
      return TasklistSubscription(
        project: project,
        currentPage: (state as TasklistSubscriptionLoading).currentPage,
      );
    }
    if (state is TasklistSubscriptionAndOpenTaskCreateDialog) {
      return TasklistSubscriptionAndOpenTaskCreateDialog(
        project: project,
        currentPage:
            (state as TasklistSubscriptionAndOpenTaskCreateDialog).currentPage,
      );
    }
    return TasklistSubscription(
      project: project,
      currentPage: state.currentPage,
    );
  }

  final ApplicationRepository _applicationRepository;

  Future<String> imageUrl(String path) async =>
      _applicationRepository.imageUrlOnStorageOf(path);

  Future<List<String>> assigneeAvatars() async {
    List<String> list = List.empty(growable: true);
    for (var assignee
        in (state as TasklistSubscription).project!.assigneeImageUrls) {
      await imageUrl(assignee).then(
        (value) => list.add(value),
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
