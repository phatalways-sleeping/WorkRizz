import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_managing_application/repositories/application_repository.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(this._applicationRepository) : super(const Splash()) {
    on<NavigateToChangePassword>(_onNavigateToChangePassword);
    on<NavigateToHome>((event, emit) {
      emit(const Home());
    });
    on<NavigateToAuthentication>(_navigateToAuthentication);
    on<NavigateToProjectsList>(_onNavigateToProjectsList);
    on<NavigateToTask>((event, emit) {
      if (event.projectId != null) {
        _applicationRepository.projectIdOnView = event.projectId!;
        _applicationRepository.isLeaderOfProjectOnView =
            event.leaderId! == _applicationRepository.userId;
        if (event.projectName != null) {
          _applicationRepository.projectOnViewName = event.projectName!;
        }
      }
      emit(const TaskList());
    });
    on<NavigateToAssistant>(_onNavigateToAssistant);
    on<NavigateToProfile>(_onNavigateToProfile);
    on<NavigateToSettings>(_onNavigateToSettings);
    on<NavigateToSubTaskDetail>((event, emit) {
      if (event.subTaskId != null) {
        _applicationRepository.subTaskIdOnView = event.subTaskId!;
      }
      if (event.taskId != null) {
        _applicationRepository.taskIdOnView = event.taskId!;
      }
      emit(const SubTaskDetail());
    });
    on<NavigateToSplash>((event, emit) async {
      await _applicationRepository.logout();
      emit(const Splash());
    });
    on<NavigateToUserProjectInvitation>((event, emit) {
      emit(const UserProjectInvitation());
    });
    on<NavigateToRedirect>((event, emit) {
      emit(const Redirect());
    });
    on<NavigateToSubTaskCreate>((event, emit) {
      _applicationRepository.taskIdOnView = event.ofTaskId;
      emit(const SubTaskCreate());
    });
    on<NavigateToFileList>((event, emit) {
      if (event.projectName != null) {
        _applicationRepository.projectOnViewName = event.projectName!;
      }
      emit(const FileList());
    });
    on<NavigateToPDFReportViewer>((event, emit) async {
      emit(PDFReportViewer(event.file));
    });
    on<NavigateToThread>((event, emit) {
      if (event.threadId != null) {
        _applicationRepository.threadIdOnView = event.threadId!;
      }
      emit(const Thread());
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
    } else if (state is TaskList || state is PDFReportViewer) {
      eventToNavigateBack = NavigateToTask(
        projectId: _applicationRepository.projectIdOnView,
        leaderId: _applicationRepository.isLeaderOfProjectOnView
            ? _applicationRepository.userId
            : '',
        projectName: null,
      );
    } else if (state is SubTaskDetail) {
      eventToNavigateBack = const NavigateToSubTaskDetail(null, null);
    } else if (state is Home) {
      eventToNavigateBack = const NavigateToHome();
    } else if (state is Settings) {
      eventToNavigateBack = const NavigateToSettings();
    } else if (state is Assistant) {
      eventToNavigateBack = const NavigateToAssistant();
    } else if (state is Splash) {
      eventToNavigateBack = const NavigateToSplash();
    } else if (state is FileList) {
      eventToNavigateBack = const NavigateToFileList(null);
    } else {
      throw Exception('Unknown state: $state');
    }

    add(const NavigateToUserProjectInvitation());
  }

  Future<void> _onNavigateToChangePassword(
    NavigateToChangePassword event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const ChangePassword());
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
}
