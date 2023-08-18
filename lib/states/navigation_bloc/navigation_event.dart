part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

final class NavigateToSplash extends NavigationEvent {
  const NavigateToSplash();
}

final class NavigateToLogin extends NavigationEvent {
  const NavigateToLogin();
}

final class NavigateToSignUp extends NavigationEvent {
  const NavigateToSignUp();
}

final class NavigateToForgotPassword extends NavigationEvent {
  const NavigateToForgotPassword();
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

