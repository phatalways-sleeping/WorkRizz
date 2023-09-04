part of 'tasklist_bloc.dart';

sealed class TasklistState extends Equatable {
  const TasklistState();
  
  @override
  List<Object> get props => [];
}

final class TasklistInitial extends TasklistState {}
