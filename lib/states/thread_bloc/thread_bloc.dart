import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_managing_application/repositories/application_repository.dart';

part 'thread_event.dart';
part 'thread_state.dart';

class ThreadBloc extends Bloc<ThreadEvent, ThreadState> {
  ThreadBloc(
    this._applicationRepository,
  ) : super(const ThreadInitial()) {
    on<ThreadSubscribeEvent>(
      (event, emit) async {
        await emit.forEach(
          _applicationRepository.threadStream(),
          onData: (data) => const ThreadSuccess(),
          onError: (error, stackTrace) => const ThreadFailure(),
        );
      },
    );
  }

  final ApplicationRepository _applicationRepository;
}
