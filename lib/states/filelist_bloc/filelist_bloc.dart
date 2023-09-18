import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_managing_application/models/exceptions/download_exception.dart';
import 'package:task_managing_application/models/project/files_small_info.dart';
import 'package:task_managing_application/repositories/repositories.dart';

part 'filelist_event.dart';
part 'filelist_state.dart';

class FilelistBloc extends Bloc<FilelistEvent, FilelistState> {
  FilelistBloc(this._applicationRepository) : super(const FilelistInitial()) {
    on<FilelistSubscibeToStreamEvent>(
      (event, emit) async {
        await emit.forEach(
          _applicationRepository.projectOnViewStream().map(
                (event) => event.filesSmallInformations,
              ),
          onData: (files) {
            files.sort((a, b) => a.taskName.compareTo(b.taskName));
            return FilelistSuccess(
              files: files,
            );
          },
          onError: (error, stackTrace) => FilelistFailureLoading(
            message: error.toString(),
          ),
        );
      },
    );

    on<FilelistDownloadFileEvent>(
      (event, emit) async {
        try {
          emit(FilelistDownloading.from(
              filelistSuccess: state as FilelistSuccess));

          final file = await _applicationRepository.downloadFile(event.path);

          emit(FilelistDownloadingSuccess.from(
              filelistSuccess: state as FilelistSuccess, file: file));
        } on DownloadException catch (e) {
          if (e is FileDownloadException) {
            emit(
              FilelistDownloadingFail.from(
                filelistSuccess: state as FilelistSuccess,
                message: 'File downloading failed',
              ),
            );
          } else {
            emit(
              FilelistDownloadingFail.from(
                filelistSuccess: state as FilelistSuccess,
                message: 'Something went wrong. Please try again',
              ),
            );
          }
        }
      },
    );

    on<FilelistRemoveFileEvent>((event, emit) async {
      emit(FilelistDownloading.from(filelistSuccess: state as FilelistSuccess));
      await _applicationRepository
          .removeFilesFromSubTask(fileUrls: [event.path]);
    });
  }

  final ApplicationRepository _applicationRepository;

  Future<String> ownerImageUrl(String ownerImageUrl) async {
    return await _applicationRepository.imageUrlOnStorageOf(ownerImageUrl);
  }
}
