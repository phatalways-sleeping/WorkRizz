// ignore_for_file: depend_on_referenced_packages

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

  Future<void> _onNavigateToSplash(
    NavigateToSplash event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Splash());
  }

  Future<void> _onNavigateToLogin(
    NavigateToLogin event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Login());
  }

  Future<void> _onNavigateToSignUp(
    NavigateToSignUp event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const SignUp());
  }

  Future<void> _onNavigateToForgotPassword(
    NavigateToForgotPassword event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const ForgotPassword());
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

  Future<void> _onNavigateToDashboard(
    NavigateToDashboard event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Dashboard());
  }
}
