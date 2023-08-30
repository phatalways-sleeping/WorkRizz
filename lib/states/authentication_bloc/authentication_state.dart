part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

final class StartingState extends AuthenticationState {
  const StartingState();
}

final class AuthenticationBySignInState extends AuthenticationState {
  const AuthenticationBySignInState();
}

sealed class AuthenticationProgessingState extends AuthenticationState {
  const AuthenticationProgessingState();
}

final class AuthenticationBySignUpProgressingState extends AuthenticationProgessingState {
  const AuthenticationBySignUpProgressingState();
}

final class AuthenticationBySignInProgressingState extends AuthenticationProgessingState {
  const AuthenticationBySignInProgressingState();
}

final class ForgetPasswordProgressingState extends AuthenticationProgessingState {
  const ForgetPasswordProgressingState();
}

final class SuccessfulAuthenticatedState extends AuthenticationState {
  const SuccessfulAuthenticatedState();
}

sealed class FailureAuthenticationState extends AuthenticationState {
  const FailureAuthenticationState(this.message);

  final String message;

  @override
  List<Object> get props => [...super.props, message];
}

final class FailureAuthenticationBySigninState extends FailureAuthenticationState {
  const FailureAuthenticationBySigninState(String message) : super(message);
}

final class FailureAuthenticationBySignupState extends FailureAuthenticationState {
  const FailureAuthenticationBySignupState(String message) : super(message);
}

final class AuthenticationBySignUpState extends AuthenticationState {
  const AuthenticationBySignUpState();
}

final class ForgetPasswordState extends AuthenticationState {
  const ForgetPasswordState();
}

final class FailureForgetPasswordState extends FailureAuthenticationState {
  const FailureForgetPasswordState(super.message);
}
