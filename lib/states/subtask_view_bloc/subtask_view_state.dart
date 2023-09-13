part of 'subtask_view_bloc.dart';

sealed class SubtaskViewState extends Equatable {
  const SubtaskViewState();

  @override
  List<Object> get props => [];
}

final class SubtaskViewInitial extends SubtaskViewState {
  const SubtaskViewInitial();
}

final class SubtaskViewLoading extends SubtaskViewState {
  const SubtaskViewLoading();
}

final class SubtaskViewSuccess extends SubtaskViewState {
  const SubtaskViewSuccess({
    required this.name,
    required this.description,
    required this.assignee,
    required this.dueDate,
    required this.isCompleted,
    required this.points,
    required this.files,
    required this.comments,
    required this.progress,
    required this.grade,
    required this.leaderComment,
  });

  factory SubtaskViewSuccess.from(SubtaskViewSuccess state) =>
      SubtaskViewSuccess(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
      );

  final String name;
  final String description;
  final String assignee;
  final DateTime dueDate;
  final bool isCompleted;
  final int points;
  final List<FileModel> files;
  final List<String> comments;
  final double progress;
  final int grade;
  final String leaderComment;

  @override
  List<Object> get props => [
        ...super.props,
        name,
        description,
        assignee,
        dueDate,
        isCompleted,
        points,
        files,
        comments,
        progress,
        grade,
        leaderComment,
      ];

  SubtaskViewSuccess copyWith({
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<FileModel>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
  }) {
    return SubtaskViewSuccess(
      name: name ?? this.name,
      description: description ?? this.description,
      assignee: assignee ?? this.assignee,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      points: points ?? this.points,
      files: files ?? this.files,
      comments: comments ?? this.comments,
      progress: progress ?? this.progress,
      grade: grade ?? this.grade,
      leaderComment: leaderComment ?? this.leaderComment,
    );
  }
}

final class SubTaskViewSuccessRequestComment extends SubtaskViewSuccess {
  const SubTaskViewSuccessRequestComment({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
  });

  factory SubTaskViewSuccessRequestComment.from(SubtaskViewSuccess state) =>
      SubTaskViewSuccessRequestComment(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
      );

  @override
  SubTaskViewSuccessRequestComment copyWith(
      {String? name,
      String? description,
      String? assignee,
      DateTime? dueDate,
      bool? isCompleted,
      int? points,
      List<FileModel>? files,
      List<String>? comments,
      double? progress,
      int? grade,
      String? leaderComment}) {
    return SubTaskViewSuccessRequestComment(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
    );
  }
}

final class SubTaskViewSuccessRequestReplyComment extends SubtaskViewSuccess {
  const SubTaskViewSuccessRequestReplyComment({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
    required this.replyUsername,
    required this.replyCommentId,
  });

  factory SubTaskViewSuccessRequestReplyComment.from(
    SubtaskViewSuccess state,
    String replyUsername,
    String replyCommentId,
  ) =>
      SubTaskViewSuccessRequestReplyComment(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
        replyUsername: replyUsername,
        replyCommentId: replyCommentId,
      );

  final String replyUsername;
  final String replyCommentId;

  @override
  List<Object> get props => [...super.props, replyUsername, replyCommentId];

  @override
  SubTaskViewSuccessRequestReplyComment copyWith({
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<FileModel>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
    String? replyUsername,
    String? replyCommentId,
  }) {
    return SubTaskViewSuccessRequestReplyComment(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
      replyUsername: replyUsername ?? this.replyUsername,
      replyCommentId: replyCommentId ?? this.replyCommentId,
    );
  }
}

final class SubTaskViewSuccessAskPermissionToOverrideFiles
    extends SubtaskViewSuccess {
  const SubTaskViewSuccessAskPermissionToOverrideFiles({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
    required this.newfiles,
  });

  final List<File> newfiles;

  factory SubTaskViewSuccessAskPermissionToOverrideFiles.from(
    SubtaskViewSuccess state,
    List<File> newFiles,
  ) =>
      SubTaskViewSuccessAskPermissionToOverrideFiles(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
        newfiles: newFiles,
      );

  @override
  SubTaskViewSuccessAskPermissionToOverrideFiles copyWith({
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<FileModel>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
    List<File>? newfiles,
  }) {
    return SubTaskViewSuccessAskPermissionToOverrideFiles(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
      newfiles: newfiles ?? this.newfiles,
    );
  }

  @override
  List<Object> get props => [...super.props, newfiles];
}

final class SubTaskViewSuccessPendingToUpdateFiles extends SubtaskViewSuccess {
  const SubTaskViewSuccessPendingToUpdateFiles({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
  });

  factory SubTaskViewSuccessPendingToUpdateFiles.from(
          SubtaskViewSuccess state) =>
      SubTaskViewSuccessPendingToUpdateFiles(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
      );

  @override
  SubTaskViewSuccessPendingToUpdateFiles copyWith(
      {String? name,
      String? description,
      String? assignee,
      DateTime? dueDate,
      bool? isCompleted,
      int? points,
      List<FileModel>? files,
      List<String>? comments,
      double? progress,
      int? grade,
      String? leaderComment}) {
    return SubTaskViewSuccessPendingToUpdateFiles(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
    );
  }
}

final class SubTaskViewSuccessPendingToUpdateComment
    extends SubtaskViewSuccess {
  const SubTaskViewSuccessPendingToUpdateComment({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
  });

  factory SubTaskViewSuccessPendingToUpdateComment.from(
          SubtaskViewSuccess state) =>
      SubTaskViewSuccessPendingToUpdateComment(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
      );

  @override
  SubTaskViewSuccessPendingToUpdateComment copyWith(
      {String? name,
      String? description,
      String? assignee,
      DateTime? dueDate,
      bool? isCompleted,
      int? points,
      List<FileModel>? files,
      List<String>? comments,
      double? progress,
      int? grade,
      String? leaderComment}) {
    return SubTaskViewSuccessPendingToUpdateComment(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
    );
  }
}

final class SubTaskViewSuccessRequestConfirmChange extends SubtaskViewSuccess {
  const SubTaskViewSuccessRequestConfirmChange({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
    required this.oldPoints,
    required this.markAsCompleted,
  });

  final int oldPoints;
  final bool markAsCompleted;

  factory SubTaskViewSuccessRequestConfirmChange.from({
    required SubtaskViewSuccess state,
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<FileModel>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
    int? oldPoints,
    bool? markAsCompleted,
  }) =>
      SubTaskViewSuccessRequestConfirmChange(
        name: name ?? state.name,
        description: description ?? state.description,
        assignee: assignee ?? state.assignee,
        dueDate: dueDate ?? state.dueDate,
        isCompleted: isCompleted ?? state.isCompleted,
        points: points ?? state.points,
        files: files ?? state.files,
        comments: comments ?? state.comments,
        progress: progress ?? state.progress,
        grade: grade ?? state.grade,
        leaderComment: leaderComment ?? state.leaderComment,
        oldPoints: oldPoints ?? state.points,
        markAsCompleted: markAsCompleted ?? state.isCompleted,
      );

  @override
  SubTaskViewSuccessRequestConfirmChange copyWith({
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<FileModel>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
    int? oldPoints,
    bool? markAsCompleted,
  }) {
    return SubTaskViewSuccessRequestConfirmChange(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
      oldPoints: oldPoints ?? this.oldPoints,
      markAsCompleted: markAsCompleted ?? this.markAsCompleted,
    );
  }

  @override
  List<Object> get props => [...super.props, oldPoints, markAsCompleted];
}

final class SubTaskLoadingSubTaskCompletion
    extends SubTaskViewSuccessRequestConfirmChange {
  const SubTaskLoadingSubTaskCompletion({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
    required super.oldPoints,
    required super.markAsCompleted,
  });

  factory SubTaskLoadingSubTaskCompletion.from(
          SubTaskViewSuccessRequestConfirmChange state) =>
      SubTaskLoadingSubTaskCompletion(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
        oldPoints: state.oldPoints,
        markAsCompleted: state.markAsCompleted,
      );

  @override
  SubTaskLoadingSubTaskCompletion copyWith({
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<FileModel>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
    int? oldPoints,
    bool? markAsCompleted,
  }) {
    return SubTaskLoadingSubTaskCompletion(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
      oldPoints: oldPoints ?? super.oldPoints,
      markAsCompleted: markAsCompleted ?? super.markAsCompleted,
    );
  }
}

final class SubtaskViewDownloading extends SubtaskViewSuccess {
  const SubtaskViewDownloading({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
  });

  factory SubtaskViewDownloading.from(SubtaskViewSuccess state) =>
      SubtaskViewDownloading(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
      );

  @override
  SubtaskViewDownloading copyWith({
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<FileModel>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
  }) {
    return SubtaskViewDownloading(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
    );
  }
}

final class SubtaskViewDownloadSuccess extends SubtaskViewSuccess {
  const SubtaskViewDownloadSuccess({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
    required this.file,
  });

  factory SubtaskViewDownloadSuccess.from(SubtaskViewSuccess state, File file) =>
      SubtaskViewDownloadSuccess(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
        file: file,
      );

  final File file;

  @override
  SubtaskViewDownloadSuccess copyWith({
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<FileModel>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
    File? file,
  }) {
    return SubtaskViewDownloadSuccess(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
      file: file ?? this.file,
    );
  }
}

final class SubtaskViewDownloadFail extends SubtaskViewSuccess {
  const SubtaskViewDownloadFail({
    required super.name,
    required super.description,
    required super.assignee,
    required super.dueDate,
    required super.isCompleted,
    required super.points,
    required super.files,
    required super.comments,
    required super.progress,
    required super.grade,
    required super.leaderComment,
    required this.message,
  });

  factory SubtaskViewDownloadFail.from(SubtaskViewSuccess state, String message) =>
      SubtaskViewDownloadFail(
        name: state.name,
        description: state.description,
        assignee: state.assignee,
        dueDate: state.dueDate,
        isCompleted: state.isCompleted,
        points: state.points,
        files: state.files,
        comments: state.comments,
        progress: state.progress,
        grade: state.grade,
        leaderComment: state.leaderComment,
        message: message,
      );

  final String message;

  @override
  SubtaskViewDownloadFail copyWith({
    String? name,
    String? description,
    String? assignee,
    DateTime? dueDate,
    bool? isCompleted,
    int? points,
    List<FileModel>? files,
    List<String>? comments,
    double? progress,
    int? grade,
    String? leaderComment,
    String? message,
  }) {
    return SubtaskViewDownloadFail(
      name: name ?? super.name,
      description: description ?? super.description,
      assignee: assignee ?? super.assignee,
      dueDate: dueDate ?? super.dueDate,
      isCompleted: isCompleted ?? super.isCompleted,
      points: points ?? super.points,
      files: files ?? super.files,
      comments: comments ?? super.comments,
      progress: progress ?? super.progress,
      grade: grade ?? super.grade,
      leaderComment: leaderComment ?? super.leaderComment,
      message: message ?? this.message,
    );
  }
}

abstract class SubtaskViewFailure extends SubtaskViewState {
  const SubtaskViewFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class SubtaskViewFailureDueToNetwork extends SubtaskViewFailure {
  const SubtaskViewFailureDueToNetwork(super.error);
}

final class SubtaskViewFailureDueToDataIntegrity extends SubtaskViewFailure {
  const SubtaskViewFailureDueToDataIntegrity(super.error);
}
