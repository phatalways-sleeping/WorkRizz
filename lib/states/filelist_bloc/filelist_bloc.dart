import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_managing_application/models/project/files_small_info.dart';
import 'package:task_managing_application/repositories/repositories.dart';

part 'filelist_event.dart';
part 'filelist_state.dart';

class FilelistBloc extends Bloc<FilelistEvent, FilelistState> {
  FilelistBloc(this._applicationRepository) : super(const FilelistInitial()) {
    on<FilelistSubscibeToStreamEvent>((event, emit) async {
      await emit.forEach(
        _applicationRepository.projectOnViewStream().map(
              (event) => event.filesSmallInformations,
            ),
        onData: (files) => FilelistSuccess(
          files: files,
        ),
        onError: (error, stackTrace) => FilelistFailureLoading(
          message: error.toString(),
        ),
      );
    });
    on<FilelistDownloadFileEvent>((event, emit) async {
      emit(FilelistDownloading.from(filelistSuccess: state as FilelistSuccess));

      // final path = await _applicationRepository.downloadFile(event.path);
    });

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
