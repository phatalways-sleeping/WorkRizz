part of 'filelist_bloc.dart';

sealed class FilelistEvent extends Equatable {
  const FilelistEvent();

  @override
  List<Object> get props => [];
}

class FilelistSubscibeToStreamEvent extends FilelistEvent {
  const FilelistSubscibeToStreamEvent();

  @override
  List<Object> get props => [];
}

class FilelistDownloadFileEvent extends FilelistEvent {
  const FilelistDownloadFileEvent(this.path);

  final String path;

  @override
  List<Object> get props => [
        path,
      ];
}

final class FilelistRemoveFileEvent extends FilelistEvent {
  const FilelistRemoveFileEvent(this.path);

  final String path;

  @override
  List<Object> get props => [
        path,
      ];
}
