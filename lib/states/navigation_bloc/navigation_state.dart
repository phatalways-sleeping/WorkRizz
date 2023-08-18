part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

final class Splash extends NavigationState {
  const Splash();
}

final class Login extends NavigationState {
  const Login();
}

final class SignUp extends NavigationState {
  const SignUp();
}

final class ForgotPassword extends NavigationState {
  const ForgotPassword();
}

final class ChangePassword extends NavigationState {
  const ChangePassword();
}

final class Home extends NavigationState {
  const Home();
}

final class Profile extends NavigationState {
  const Profile();
}

final class Settings extends NavigationState {
  const Settings();
}

final class Dashboard extends NavigationState {
  const Dashboard();
}
