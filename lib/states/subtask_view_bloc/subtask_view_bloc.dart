import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_managing_application/models/sub_task/comment/comment_model.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';
import 'package:task_managing_application/repositories/repositories.dart';

part 'subtask_view_event.dart';
part 'subtask_view_state.dart';

class SubtaskViewBloc extends Bloc<SubtaskViewEvent, SubtaskViewState> {
  SubtaskViewBloc(
    this._applicationRepository,
  ) : super(const SubtaskViewInitial()) {
    on<SubTaskSubscribeEvent>(
      (event, emit) async {
        await emit.forEach(
          _applicationRepository.subTaskStream(),
          onData: streamTransformation,
          onError: (error, stackTrace) => SubtaskViewFailureDueToNetwork(
            error.toString(),
          ),
        );
      },
    );
    on<SubTaskInputDueDateEvent>((event, emit) async {});
    on<SubTaskInputPointsEvent>((event, emit) async {});
    on<SubTaskInputDescriptionEvent>((event, emit) async {});
    on<SubTaskInputAttachmentEvent>((event, emit) async {
      await _applicationRepository.pickFiles().then((value) async {
        final files = (state as SubtaskViewSuccess).files;
        final newFiles = value.map((e) => e.path.split('/').last).toList();
        if (files
            .map((e) => e.split('/').last)
            .any((element) => newFiles.contains(element))) {
          emit(
            SubTaskViewSuccessAskPermissionToOverrideFiles.from(
              state as SubtaskViewSuccess,
              value,
            ),
          );
        } else {
          emit(SubTaskViewSuccessPendingToUpdateFiles.from(
              state as SubtaskViewSuccess));
          await _applicationRepository
              .updateFilesWithOverridePermissionToSubTask(files: value);
        }
      }).onError((error, stackTrace) {
        emit(SubtaskViewFailureDueToNetwork(error.toString()));
      });
    });
    on<SubTaskAcceptOverrideAttachments>((event, emit) async {
      emit(SubTaskViewSuccessPendingToUpdateFiles.from(
          state as SubtaskViewSuccess));
      await _applicationRepository.updateFilesWithOverridePermissionToSubTask(
          files: event.files);
    });
    on<SubTaskRejectOverrideAttachments>((event, emit) async {
      emit(SubTaskViewSuccessPendingToUpdateFiles.from(
          state as SubtaskViewSuccess));
      await _applicationRepository
          .updateFilesWithoutOverridePermissionToSubTask(files: event.files);
    });
    on<SubTaskDeleteAttachmentEvent>((event, emit) async {
      emit(SubTaskViewSuccessPendingToUpdateFiles.from(
          state as SubtaskViewSuccess));
      await _applicationRepository
          .removeFilesFromSubTask(fileUrls: [event.attachment]);
    });
    on<SubTaskDownloadAttachmentEvent>((event, emit) async {});
    on<SubTaskInputGradeEvent>((event, emit) async {});
    on<SubTaskInputProgressEvent>((event, emit) async {});
    on<SubTaskInputLeaderCommentEvent>((event, emit) async {});
    on<SubTaskRequestInputSubTaskCommentEvent>((event, emit) {
      emit(SubTaskViewSuccessRequestComment.from(state as SubtaskViewSuccess));
    });
    on<SubTaskRemoveSubTaskCommentEvent>((event, emit) async {
      await _applicationRepository.removeCommentOutOfSubTask(
        commentId: event.commentId,
      );
    });
    on<SubTaskCancelRequestInputSubTaskCommentEvent>((event, emit) {
      if (state is SubTaskViewSuccessRequestComment) {
        emit(
            SubtaskViewSuccess.from(state as SubTaskViewSuccessRequestComment));
      } else {
        emit(
          SubtaskViewSuccess.from(
            state as SubTaskViewSuccessRequestReplyComment,
          ),
        );
      }
    });
    on<SubTaskRequestReplyToCommentEvent>(
      (event, emit) {
        emit(
          SubTaskViewSuccessRequestReplyComment.from(
            state as SubtaskViewSuccess,
            event.replyToUsername,
            event.commentId,
          ),
        );
      },
    );
    on<SubTaskInputSubTaskCommentEvent>((event, emit) async {
      if (event.comment.isEmpty) {
        return;
      }
      emit(
        SubTaskViewSuccessPendingToUpdateComment.from(
            state as SubtaskViewSuccess),
      );
      await _applicationRepository.createNewComment(comment: event.comment);
    });
    on<SubTaskReplyToCommentEvent>((event, emit) async {
      if (event.comment.isEmpty) {
        return;
      }
      final repliedCommentId =
          (state as SubTaskViewSuccessRequestReplyComment).replyCommentId;
      final repliedToUsername =
          (state as SubTaskViewSuccessRequestReplyComment).replyUsername;
      emit(
        SubTaskViewSuccessPendingToUpdateComment.from(
            state as SubtaskViewSuccess),
      );
      await _applicationRepository.repliedToComment(
        repliedCommentId: repliedCommentId,
        repliedToUsername: repliedToUsername,
        message: event.comment,
      );
    });
    on<SubTaskMarkCommentSolvedEvent>((event, emit) async {
      await _applicationRepository.markCommentSolved(
          commentId: event.commentId);
    });
    on<SubTaskMarkCommentUnsolvedEvent>((event, emit) async {
      await _applicationRepository.markCommentUnSolved(
          commentId: event.commentId);
    });
  }

  final ApplicationRepository _applicationRepository;

  String get projectName => _applicationRepository.projectOnViewName;

  Future<String> assigneeImage() async {
    final assignee = await _applicationRepository
        .userStream((state as SubtaskViewSuccess).assignee)
        .first
        .then(
          (value) => value.imageUrl,
        );
    return _applicationRepository.imageUrlOnStorageOf(assignee);
  }

  Future<String> imageUrlOf(String userId) async {
    final user = await _applicationRepository.userStream(userId).first;
    return _applicationRepository.imageUrlOnStorageOf(user.imageUrl);
  }

  Future<String> ownerUsernameOF(String commentId) async {
    final comment =
        await _applicationRepository.commentStream(commentId).first.then(
              (value) => value.commenter,
            );
    final user = await _applicationRepository.userStream(comment).first;
    return user.username;
  }

  Stream<UserActivityModel> userActivityStream(String userId) =>
      _applicationRepository.userActivityStream(userId);

  Stream<CommentModel> commentStream(String commentId) =>
      _applicationRepository.commentStream(commentId);

  bool get isLeader => _applicationRepository.isLeaderOfProjectOnView;

  bool get isAssigned =>
      _applicationRepository.userId == (state as SubtaskViewSuccess).assignee;

  SubtaskViewState streamTransformation(subTask) =>
      (state is SubTaskViewSuccessRequestComment)
          ? SubTaskViewSuccessRequestComment(
              name: subTask.name,
              description: subTask.description,
              assignee: subTask.assignee,
              dueDate: subTask.dueDate,
              isCompleted: subTask.isCompleted,
              points: subTask.points,
              files: subTask.files,
              comments: subTask.comments,
              progress: subTask.progress,
              grade: subTask.grade,
              leaderComment: subTask.leaderComment,
            )
          : (state is SubTaskViewSuccessRequestReplyComment)
              ? SubTaskViewSuccessRequestReplyComment(
                  name: subTask.name,
                  description: subTask.description,
                  assignee: subTask.assignee,
                  dueDate: subTask.dueDate,
                  isCompleted: subTask.isCompleted,
                  points: subTask.points,
                  files: subTask.files,
                  comments: subTask.comments,
                  progress: subTask.progress,
                  grade: subTask.grade,
                  leaderComment: subTask.leaderComment,
                  replyUsername:
                      (state as SubTaskViewSuccessRequestReplyComment)
                          .replyUsername,
                  replyCommentId:
                      (state as SubTaskViewSuccessRequestReplyComment)
                          .replyCommentId,
                )
              : SubtaskViewSuccess(
                  name: subTask.name,
                  description: subTask.description,
                  assignee: subTask.assignee,
                  dueDate: subTask.dueDate,
                  isCompleted: subTask.isCompleted,
                  points: subTask.points,
                  files: subTask.files,
                  comments: subTask.comments,
                  progress: subTask.progress,
                  grade: subTask.grade,
                  leaderComment: subTask.leaderComment,
                );
}
