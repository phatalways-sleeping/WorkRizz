import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/repositories/repositories.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this._applicationRepository,
  ) : super(const HomeInitial()) {
    on<HomeSubscribeEvent>((event, emit) async {
      await emit.forEach(
        _applicationRepository.userStream(_applicationRepository.userId),
        onData: (user) => HomeSuccess(
          subTaskIds: user.subTasks,
          username: user.username,
        ),
        onError: (error, stackTrace) => const HomeError(),
      );
    });
    on<HomeMarkSubTaskCompleteEvent>((event, emit) async {
      final Task task = await _applicationRepository.projectIdOfSubTask(
        event.subTaskId,
      ).then((value) => value);

      final String taskId = task.id;
      final String projectId = task.project;

      _applicationRepository.projectIdOnView = projectId;


      await _applicationRepository.markSubTaskCompleted(
        subTaskId: event.subTaskId,
        taskId: taskId,
      );
    });
  }

  final ApplicationRepository _applicationRepository;

  Future<Map<String, List<Stream<SubTaskModel>>>> subTasksForEachProject() async =>
      _applicationRepository
          .subTasksForEachProject((state as HomeSuccess).subTaskIds);

  Future<String> projectName(String projectId) async =>
      _applicationRepository.projectNameOfProject(projectId);

  Future<int> tagCount(String projectId) async =>
      _applicationRepository.tagsCountOfProject(projectId);
}
