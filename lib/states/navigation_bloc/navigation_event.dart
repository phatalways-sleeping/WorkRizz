part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

final class NavigateToTestComponents extends NavigationEvent {
  const NavigateToTestComponents();
}

final class NavigateToAuthentication extends NavigationEvent {
  const NavigateToAuthentication();
}

final class NavigateToChangePassword extends NavigationEvent {
  const NavigateToChangePassword();
}

final class NavigateToHome extends NavigationEvent {
  const NavigateToHome();
}

final class NavigateToProfile extends NavigationEvent {
  const NavigateToProfile();
}

final class NavigateToSettings extends NavigationEvent {
  const NavigateToSettings();
}

final class NavigateToProjectsList extends NavigationEvent {
  const NavigateToProjectsList();
}

final class NavigateToTask extends NavigationEvent {
  const NavigateToTask({
    required this.projectId,
    required this.leaderId,
    required this.projectName,
  }) : assert(projectId == null || leaderId != null,
            'If projectId is not null, leaderId must not be null');

  final String? projectId;
  final String? leaderId;
  final String? projectName;

  @override
  List<Object> get props => [
        ...super.props,
        if (projectId != null) projectId!,
        if (leaderId != null) leaderId!,
        if (projectName != null) projectName!,
      ];
}

final class NavigateToAssistant extends NavigationEvent {
  const NavigateToAssistant();
}

final class NavigateToSubTaskDetail extends NavigationEvent {
  const NavigateToSubTaskDetail(this.subTaskId);

  final String? subTaskId;
  
  @override
  List<Object> get props => [...super.props, if(subTaskId != null) subTaskId!];
}

final class NavigateToSplash extends NavigationEvent {
  const NavigateToSplash();
}

final class NavigateToUserProjectInvitation extends NavigationEvent {
  const NavigateToUserProjectInvitation();
}

final class NavigateToSubTaskCreate extends NavigationEvent {
  const NavigateToSubTaskCreate(
    this.ofTaskId,
  );

  final String ofTaskId;

  @override
  List<Object> get props => [...super.props, ofTaskId];
}
