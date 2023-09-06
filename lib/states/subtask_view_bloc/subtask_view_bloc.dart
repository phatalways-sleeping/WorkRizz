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
          onData: (subTask) => (state is SubTaskViewSuccessRequestComment)
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
                ),
          onError: (error, stackTrace) => SubtaskViewFailureDueToNetwork(
            error.toString(),
          ),
        );
      },
    );
    on<SubTaskInputDueDateEvent>((event, emit) async {});
    on<SubTaskInputPointsEvent>((event, emit) async {});
    on<SubTaskInputDescriptionEvent>((event, emit) async {});
    on<SubTaskInputAttachmentEvent>((event, emit) async {});
    on<SubTaskDeleteAttachmentEvent>((event, emit) async {});
    on<SubTaskDownloadAttachmentEvent>((event, emit) async {});
    on<SubTaskInputGradeEvent>((event, emit) async {});
    on<SubTaskInputProgressEvent>((event, emit) async {});
    on<SubTaskInputLeaderCommentEvent>((event, emit) async {});
    on<SubTaskRequestInputSubTaskCommentEvent>((event, emit) {
      emit(SubTaskViewSuccessRequestComment.from(state as SubtaskViewSuccess));
    });
    on<SubTaskCancelRequestInputSubTaskCommentEvent>((event, emit) {
      emit(SubtaskViewSuccess.from(state as SubTaskViewSuccessRequestComment));
    });
    on<SubTaskRequestReplyToCommentEvent>(
      (event, emit) {
        emit(
          SubTaskViewSuccessRequestReplyComment.from(
            state as SubtaskViewSuccess,
            event.replyToUsername,
          ),
        );
      },
    );
    on<SubTaskInputSubTaskCommentEvent>((event, emit) async {});
    on<SubTaskReplyToCommentEvent>((event, emit) async {});
    on<SubTaskMarkCommentSolvedEvent>((event, emit) async {});
    on<SubTaskMarkCommentUnsolvedEvent>((event, emit) async {});
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
    final comment = await _applicationRepository
        .commentStream(commentId)
        .first
        .then(
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
}
