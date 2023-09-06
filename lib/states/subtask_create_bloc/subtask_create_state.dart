part of 'subtask_create_bloc.dart';

sealed class SubtaskCreateState extends Equatable {
  const SubtaskCreateState();
  
  @override
  List<Object> get props => [];
}

final class SubtaskCreateInitial extends SubtaskCreateState {}
