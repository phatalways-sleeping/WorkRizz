part of 'filelist_bloc.dart';

sealed class FilelistState extends Equatable {
  const FilelistState();

  @override
  List<Object> get props => [];
}

final class FilelistInitial extends FilelistState {
  const FilelistInitial();
}

final class FilelistLoading extends FilelistState {
  const FilelistLoading();
}

final class FilelistSuccess extends FilelistState {
  const FilelistSuccess({
    required this.files,
  });

  final List<FilesSmallInformation> files;

  @override
  List<Object> get props => [
        files,
      ];

  FilelistSuccess copyWith({
    List<FilesSmallInformation>? files,
  }) {
    return FilelistSuccess(
      files: files ?? this.files,
    );
  }
}

final class FilelistDownloading extends FilelistSuccess {
  const FilelistDownloading({
    required super.files,
  });

  factory FilelistDownloading.from({
    required FilelistSuccess filelistSuccess,
  }) {
    return FilelistDownloading(
      files: filelistSuccess.files,
    );
  }

  @override
  FilelistDownloading copyWith({
    List<FilesSmallInformation>? files,
  }) {
    return FilelistDownloading(
      files: files ?? this.files,
    );
  }
}

final class FilelistDownloadingSuccess extends FilelistSuccess {
  const FilelistDownloadingSuccess({
    required super.files,
    required this.file,
  });

  factory FilelistDownloadingSuccess.from({
    required FilelistSuccess filelistSuccess,
    required File file,
  }) {
    return FilelistDownloadingSuccess(
      files: filelistSuccess.files,
      file: file,
    );
  }

  final File file;

  @override
  FilelistDownloadingSuccess copyWith({
    List<FilesSmallInformation>? files,
    File? file,
  }) {
    return FilelistDownloadingSuccess(
      files: files ?? this.files,
      file: file ?? this.file,
    );
  }

  @override
  List<Object> get props => [
        file,
        files,
      ];
}

final class FilelistDownloadingFail extends FilelistSuccess {
  const FilelistDownloadingFail({
    required super.files,
    required this.message,
  });

  factory FilelistDownloadingFail.from({
    required FilelistSuccess filelistSuccess,
    required String message,
  }) {
    return FilelistDownloadingFail(
      files: filelistSuccess.files,
      message: message,
    );
  }

  final String message;

  @override
  FilelistDownloadingFail copyWith({
    List<FilesSmallInformation>? files,
    String? message,
  }) {
    return FilelistDownloadingFail(
      files: files ?? this.files,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        message,
        files,
      ];
}

sealed class FilelistFailure extends FilelistState {
  const FilelistFailure({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [
        message,
      ];
}

final class FilelistFailureDownloading extends FilelistFailure {
  const FilelistFailureDownloading({
    required super.message,
  });
}

final class FilelistFailureLoading extends FilelistFailure {
  const FilelistFailureLoading({
    required super.message,
  });
}

final class FilelistFailureNoInternet extends FilelistFailure {
  const FilelistFailureNoInternet({
    required super.message,
  });
}
