part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

final class Assistant extends NavigationState {
  const Assistant();
}

final class ProjectsList extends NavigationState {
  const ProjectsList();
}

final class Authentication extends NavigationState {
  const Authentication();
}

final class TestComponents extends NavigationState {
  const TestComponents();
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

final class Task extends NavigationState {
  const Task();
}