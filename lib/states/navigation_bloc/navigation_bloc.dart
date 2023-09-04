// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_managing_application/repositories/application_repository.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(this._applicationRepository) : super(const SubTaskDetail()) {
    on<NavigateToTestComponents>(_onNavigateToTestComponents);
    on<NavigateToChangePassword>(_onNavigateToChangePassword);
    on<NavigateToHome>(_onNavigateToHome);
    on<NavigateToAuthentication>(_navigateToAuthentication);
    on<NavigateToProjectsList>(_onNavigateToProjectsList);
    on<NavigateToProjectView>((event, emit) {
      _applicationRepository.projectIdOnView = event.projectId;
      emit(const ProjectDetail());
    });
    on<NavigateToAssistant>(_onNavigateToAssistant);
    on<NavigateToProfile>(_onNavigateToProfile);
    on<NavigateToSettings>(_onNavigateToSettings);
    on<NavigateToTask>(_onNavigateToTask);
    on<NavigateToSubTaskDetail>(_onNavigateToSubTaskDetail);
  }

  final ApplicationRepository _applicationRepository;

  Future<void> _onNavigateToTestComponents(
    NavigateToTestComponents event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const TestComponents());
  }

  Future<void> _onNavigateToChangePassword(
    NavigateToChangePassword event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const ChangePassword());
  }

  Future<void> _onNavigateToHome(
    NavigateToHome event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Home());
  }

  Future<void> _onNavigateToProfile(
    NavigateToProfile event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Profile());
  }

  Future<void> _onNavigateToSettings(
    NavigateToSettings event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Settings());
  }

  Future<void> _onNavigateToProjectsList(
    NavigateToProjectsList event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const ProjectsList());
  }

  Future<void> _onNavigateToAssistant(
    NavigateToAssistant event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Assistant());
  }

  Future<void> _navigateToAuthentication(
    NavigateToAuthentication event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Authentication());
  }

  Future<void> _onNavigateToTask(
    NavigateToTask event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const TaskList());
  }

  Future<void> _onNavigateToSubTaskDetail(
    NavigateToSubTaskDetail event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const SubTaskDetail());
  }
}
