import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/repositories/application_repository.dart';
import 'package:uuid/v8.dart';
part 'subtask_create_event.dart';
part 'subtask_create_state.dart';

class SubtaskCreateBloc extends Bloc<SubtaskCreateEvent, SubtaskCreateState> {
  SubtaskCreateBloc(
    this._applicationRepository,
  ) : super(const SubtaskCreateInitial()) {
    on<SubTaskCreateSubscribeToTaskEvent>((event, emit) async {
      await emit.forEach(
        _applicationRepository.projectOnViewStream(),
        onData: (project) => SubtaskCreateSuccess(
          projectMembers: [
            ...project.assignees,
            project.leader,
          ],
          projectDueDate: project.endDate,
          projectName: project.name,
          subTaskName: (state is SubtaskCreateSuccess)
              ? (state as SubtaskCreateSuccess).subTaskName
              : null,
          dueDate: (state is SubtaskCreateSuccess)
              ? (state as SubtaskCreateSuccess).dueDate
              : null,
          description: (state is SubtaskCreateSuccess)
              ? (state as SubtaskCreateSuccess).description
              : null,
          assignedTo: (state is SubtaskCreateSuccess)
              ? (state as SubtaskCreateSuccess).assignedTo
              : null,
          points: (state is SubtaskCreateSuccess)
              ? (state as SubtaskCreateSuccess).points
              : null,
          attachments: (state is SubtaskCreateSuccess)
              ? (state as SubtaskCreateSuccess).attachments
              : null,
        ),
        onError: (error, stackTrace) => SubtaskCreateFailureDueToNetwork(
          error: error.toString(),
        ),
      );
    });

    on<SubTaskRemoveCurrentEvent>((event, emit) async {
      emit(const SubtaskCreateInitial());
    });

    on<SubTaskInputNameEvent>((event, emit) async {
      final usedState = state as SubtaskCreateSuccess;
      emit(usedState.copyWith(
        subTaskName: event.name,
      ));
    });

    on<SubTaskInputDescriptionEvent>((event, emit) async {
      final usedState = state as SubtaskCreateSuccess;
      emit(usedState.copyWith(
        description: event.description,
      ));
    });

    on<SubTaskInputDueDateEvent>((event, emit) async {
      final usedState = state as SubtaskCreateSuccess;
      emit(usedState.copyWith(
        dueDate: event.dueDate,
      ));
    });

    on<SubTaskInputAssignedToEvent>((event, emit) async {
      final usedState = state as SubtaskCreateSuccess;
      final memberId = await _applicationRepository
          .userStreamByEmail(event.email)
          .first
          .then((value) => value.id);
      emit(usedState.copyWith(
        assignedTo: memberId,
      ));
    });

    on<SubTaskInputPointsEvent>((event, emit) async {
      final usedState = state as SubtaskCreateSuccess;
      emit(usedState.copyWith(
        points: event.points,
      ));
    });

    on<SubTaskInputAttachmentsEvent>((event, emit) async {
      final usedState = state as SubtaskCreateSuccess;
      final files = await _applicationRepository.pickFiles().onError(
            (error, stackTrace) => [],
          );
      emit(usedState.copyWith(
        attachments: [
          if (usedState.attachments != null) ...usedState.attachments!,
          ...files,
        ],
      ));
    });

    on<SubTaskRemoveAttachmentEvent>((event, emit) async {
      final usedState = state as SubtaskCreateSuccess;
      if (usedState.attachments == null || usedState.attachments!.isEmpty) {
        return;
      }
      emit(
        usedState.copyWith(
          attachments: [
            ...usedState.attachments!.where(
              (element) => element.path != event.attachment.path,
            ),
          ],
        ),
      );
    });

    on<SubTaskDownloadAttachmentEvent>((event, emit) async {
      // final usedState = state as SubtaskCreateSuccess;
      // final file = await _applicationRepository.downloadFile(
      //   fileId: event.fileId,
      // );
      // emit(usedState.copyWith(
      //   attachments: [
      //     if (usedState.attachments != null) ...usedState.attachments!,
      //     file,
      //   ],
      // ));
    });

    on<SubTaskRequestToCreateEvent>(
      (event, emit) async {
        final usedState = state as SubtaskCreateSuccess;
        if (usedState.subTaskName == null || usedState.subTaskName!.isEmpty) {
          emit(
            const SubTaskCreateFailureDueToDataIntegrity(
              error: 'Subtask name is empty',
            ),
          );
          return;
        }

        if (usedState.dueDate != null &&
            usedState.dueDate!.isBefore(DateTime.now())) {
          emit(
            const SubTaskCreateFailureDueToDataIntegrity(
              error: 'Due date is before current date',
            ),
          );
          return;
        }

        if (usedState.dueDate != null &&
            usedState.dueDate!
                    .difference((state as SubtaskCreateSuccess).projectDueDate)
                    .inDays >
                0) {
          emit(
            const SubTaskCreateFailureDueToDataIntegrity(
              error: 'Due date is after project due date',
            ),
          );
          return;
        }

        if (usedState.description == null || usedState.description!.isEmpty) {
          emit(
            const SubTaskCreateFailureDueToDataIntegrity(
              error: 'Description is empty',
            ),
          );
          return;
        }

        if (usedState.assignedTo == null || usedState.assignedTo!.isEmpty) {
          emit(
            const SubTaskCreateFailureDueToDataIntegrity(
              error: 'Assignee is empty',
            ),
          );
          return;
        }

        if (!(state as SubtaskCreateSuccess).projectMembers.contains(
              usedState.assignedTo,
            )) {
          emit(
            const SubTaskCreateFailureDueToDataIntegrity(
              error: 'Assignee is not a member of the project',
            ),
          );
          return;
        }

        if (usedState.points == null) {
          emit(
            const SubTaskCreateFailureDueToDataIntegrity(
              error: 'Points is empty',
            ),
          );
          return;
        }

        if (usedState.points != null && usedState.points! <= 0) {
          emit(
            const SubTaskCreateFailureDueToDataIntegrity(
              error: 'Points must be greater than 0',
            ),
          );
          return;
        }

        // Create subtask
        final subTask = SubTaskModel(
          id: const UuidV8().generate(),
          name: usedState.subTaskName!,
          description: usedState.description!,
          assignee: usedState.assignedTo!,
          dueDate: usedState.dueDate?? DateTime.now(),
          isCompleted: false,
          points: usedState.points!,
          files: const [],
          comments: const [],
          progress: 0.0,
          grade: 0,
          leaderComment: '',
        );
        final files = usedState.attachments ?? [];
        emit(const SubtaskCreateLoading());
        await _applicationRepository.createNewSubTask(
          newSubTask: subTask,
          files: files,
        ).then((value) => debugPrint('Subtask created successfully'));
      },
    );
  }

  final ApplicationRepository _applicationRepository;

  Future<String> assigneeImage() async {
    final usedState = state as SubtaskCreateSuccess;
    final member =
        await _applicationRepository.userStream(usedState.assignedTo!).first;

    return _applicationRepository.imageUrlOnStorageOf(member.imageUrl);
  }
}
