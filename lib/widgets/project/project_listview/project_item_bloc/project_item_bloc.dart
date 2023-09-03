import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';

part 'project_item_event.dart';
part 'project_item_state.dart';

class ProjectItemBloc extends Bloc<ProjectItemEvent, ProjectItemState> {
  ProjectItemBloc(
    this._stream,
    this.userId,
    this.imageFuture,
  ) : super(const ProjectItemInitial()) {
    on<ProjectItemSubscribeToProjectEvent>(
      (event, emit) async {
        await emit.forEach(
          _stream(event.projectId),
          onData: (project) => (state is ProjectItemInitial ||
                  state is ProjectItemError ||
                  state is ProjectItemSuccess ||
                  state is ProjectItemLoadingNonFilter)
              ? ProjectItemSuccess(
                  totalFileLinks: project.totalFileLinks,
                  name: project.name,
                  assigneeImageUrls: project.assigneeImageUrls,
                  leaderImageUrl: project.leaderImageUrl,
                  isCompleted: project.isCompleted,
                  endDate: project.endDate,
                  tags: project.tags,
                  thread: project.thread,
                  leader: project.leader,
                )
              : (state as ProjectItemSuccessWithFilterStatus).copyWith(
                  name: project.name,
                  assigneeImageUrls: project.assigneeImageUrls,
                  leaderImageUrl: project.leaderImageUrl,
                  isCompleted: project.isCompleted,
                  endDate: project.endDate,
                  tags: project.tags,
                  thread: project.thread,
                  leader: project.leader,
                  totalFileLinks: project.totalFileLinks,
                ),
          onError: (error, stackTrace) => const ProjectItemError(),
        );
      },
    );
    on<ProjectItemFilterEvent>((event, emit) {
      if (event.filterStatus == FilterStatus.none) {
        state as ProjectItemSuccessWithFilterStatus;
        emit(
          ProjectItemSuccess(
            totalFileLinks: state.totalFileLinks,
            name: state.name,
            assigneeImageUrls: state.assigneeImageUrls,
            leaderImageUrl: state.leaderImageUrl,
            isCompleted: state.isCompleted,
            endDate: state.endDate,
            tags: state.tags,
            thread: state.thread,
            leader: state.leader,
          ),
        );
      } else {
        final filterColor =
            (event.filterStatus == FilterStatus.completed && state.isCompleted!)
                ? const Color(0xFF9C9AFF)
                : (event.filterStatus == FilterStatus.ongoing &&
                        !state.isCompleted!)
                    ? const Color(0xFFEAB0FC)
                    : (event.filterStatus == FilterStatus.leader &&
                            state.leader! == userId)
                        ? const Color(0xFF5CD669)
                        : Colors.white;
        if (state is ProjectItemSuccess) {
          emit(
            ProjectItemSuccessWithFilterStatus(
              name: state.name,
              assigneeImageUrls: state.assigneeImageUrls,
              leaderImageUrl: state.leaderImageUrl,
              isCompleted: state.isCompleted,
              endDate: state.endDate,
              tags: state.tags,
              thread: state.thread,
              filterColor: filterColor,
              leader: state.leader,
              totalFileLinks: state.totalFileLinks,
            ),
          );
        } else {
          emit(
            (state as ProjectItemSuccessWithFilterStatus).copyWith(
              filterColor: filterColor,
            ),
          );
        }
      }
    });
  }

  final Future<String> Function(String) imageFuture;
  final Stream<Project> Function(String) _stream;
  final String userId;

  Future<List<NetworkImage>> assigneeAvatars() async {
    List<NetworkImage> list = List.empty(growable: true);
    for (var assignee in state.assigneeImageUrls!) {
      await imageFuture(assignee).then(
        (value) => list.add(
          NetworkImage(value),
        ),
      );
    }
    return list;
  }
}
