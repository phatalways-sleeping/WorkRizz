import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subtask_create_event.dart';
part 'subtask_create_state.dart';

class SubtaskCreateBloc extends Bloc<SubtaskCreateEvent, SubtaskCreateState> {
  SubtaskCreateBloc() : super(SubtaskCreateInitial()) {
    on<SubtaskCreateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
