import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const Splash()) {
    on<NavigateToSplash>(_onNavigateToSplash);
    on<NavigateToLogin>(_onNavigateToLogin);
    on<NavigateToSignUp>(_onNavigateToSignUp);
    on<NavigateToForgotPassword>(_onNavigateToForgotPassword);
    on<NavigateToChangePassword>(_onNavigateToChangePassword);
    on<NavigateToHome>(_onNavigateToHome);
    on<NavigateToProfile>(_onNavigateToProfile);
    on<NavigateToSettings>(_onNavigateToSettings);
    on<NavigateToDashboard>(_onNavigateToDashboard);
  }

  FutureOr<void> _onNavigateToSplash(
    NavigateToSplash event,
    Emitter<NavigationState> emit,
  ) {
    emit(const Splash());
  }

  FutureOr<void> _onNavigateToLogin(
    NavigateToLogin event,
    Emitter<NavigationState> emit,
  ) {
    emit(const Login());
  }

  FutureOr<void> _onNavigateToSignUp(
    NavigateToSignUp event,
    Emitter<NavigationState> emit,
  ) {
    emit(const SignUp());
  }

  FutureOr<void> _onNavigateToForgotPassword(
    NavigateToForgotPassword event,
    Emitter<NavigationState> emit,
  ) {
    emit(const ForgotPassword());
  }

  FutureOr<void> _onNavigateToChangePassword(
    NavigateToChangePassword event,
    Emitter<NavigationState> emit,
  ) {
    emit(const ChangePassword());
  }

  FutureOr<void> _onNavigateToHome(
    NavigateToHome event,
    Emitter<NavigationState> emit,
  ) {
    emit(const Home());
  }

  FutureOr<void> _onNavigateToProfile(
    NavigateToProfile event,
    Emitter<NavigationState> emit,
  ) {
    emit(const Profile());
  }

  FutureOr<void> _onNavigateToSettings(
    NavigateToSettings event,
    Emitter<NavigationState> emit,
  ) {
    emit(const Settings());
  }

  FutureOr<void> _onNavigateToDashboard(
    NavigateToDashboard event,
    Emitter<NavigationState> emit,
  ) {
    emit(const Dashboard());
  }
}
