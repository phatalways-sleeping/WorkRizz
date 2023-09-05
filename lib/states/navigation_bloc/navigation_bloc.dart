// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_managing_application/repositories/application_repository.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(this._applicationRepository) : super(const ProjectsList()) {
    on<NavigateToTestComponents>(_onNavigateToTestComponents);
    on<NavigateToChangePassword>(_onNavigateToChangePassword);
    on<NavigateToHome>(_onNavigateToHome);
    on<NavigateToAuthentication>(_navigateToAuthentication);
    on<NavigateToProjectsList>(_onNavigateToProjectsList);
    on<NavigateToTask>((event, emit) {
      _applicationRepository.projectIdOnView = event.projectId;
      emit(const TaskList());
    });
    on<NavigateToAssistant>(_onNavigateToAssistant);
    on<NavigateToProfile>(_onNavigateToProfile);
    on<NavigateToSettings>(_onNavigateToSettings);
    on<NavigateToSubTaskDetail>(_onNavigateToSubTaskDetail);
    on<NavigateToSplash>((event, emit) async {
      await _applicationRepository.logout();
      emit(const Splash());
    });
    on<NavigateToUserProjectInvitation>((event, emit) {
      emit(const UserProjectInvitation());
    });
  }

  final ApplicationRepository _applicationRepository;

  late NavigationEvent eventToNavigateBack;

  void navigateBack() {
    add(eventToNavigateBack);
  }

  void mapCurrentStateToEventThenEmit(NavigationState state) {
    if (state is ProjectsList) {
      eventToNavigateBack = const NavigateToProjectsList();
    } else if (state is TaskList) {
      eventToNavigateBack = NavigateToTask(_applicationRepository.projectIdOnView);
    } else if (state is SubTaskDetail) {
      eventToNavigateBack = const NavigateToSubTaskDetail();
    } else if (state is Home) {
      eventToNavigateBack = const NavigateToHome();
    } else if (state is Settings) {
      eventToNavigateBack = const NavigateToSettings();
    } else if (state is Assistant) {
      eventToNavigateBack = const NavigateToAssistant();
    } else if (state is TestComponents) {
      eventToNavigateBack = const NavigateToTestComponents();
    } else if (state is Splash) {
      eventToNavigateBack = const NavigateToSplash();
    } else {
      throw Exception('Unknown state: $state');
    }

    add(const NavigateToUserProjectInvitation());
  }

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

  Future<void> _onNavigateToSubTaskDetail(
    NavigateToSubTaskDetail event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const SubTaskDetail());
  }
}
