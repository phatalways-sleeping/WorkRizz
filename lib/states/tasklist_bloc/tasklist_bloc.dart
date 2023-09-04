import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tasklist_event.dart';
part 'tasklist_state.dart';

class TasklistBloc extends Bloc<TasklistEvent, TasklistState> {
  TasklistBloc() : super(TasklistInitial()) {
    on<TasklistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
