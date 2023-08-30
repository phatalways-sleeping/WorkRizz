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

final class NavigateToDashboard extends NavigationEvent {
  const NavigateToDashboard();
}

final class NavigateToProjectsList extends NavigationEvent {
  const NavigateToProjectsList();
}

final class NavigateToAssistant extends NavigationEvent {
  const NavigateToAssistant();
}
