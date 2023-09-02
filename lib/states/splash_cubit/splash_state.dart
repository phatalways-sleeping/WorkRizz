part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoading extends SplashState {
  const SplashLoading();
}

final class SplashToLogin extends SplashState {
  const SplashToLogin();
}

final class SplashToHome extends SplashState {
  const SplashToHome();
}
