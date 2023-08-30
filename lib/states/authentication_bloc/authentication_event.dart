part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class LoginEvent extends AuthenticationEvent {
  const LoginEvent();
}

final class SignUpEvent extends AuthenticationEvent {
  const SignUpEvent();
}

final class ForgetPasswordEvent extends AuthenticationEvent {
  const ForgetPasswordEvent();
}

final class RequestForgetPasswordEvent extends AuthenticationEvent {
  const RequestForgetPasswordEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}


abstract class RequestAuthenticationEvent extends AuthenticationEvent {
  const RequestAuthenticationEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [...super.props, email, password];
}

final class RequestSigninEvent extends RequestAuthenticationEvent {
  const RequestSigninEvent({
    required super.email,
    required super.password,
  });
}

final class RequestSignupEvent extends RequestAuthenticationEvent {
  const RequestSignupEvent({
    required super.email,
    required super.password,
    required this.username,
    required this.confirmPassword,
  });

  final String username;
  final String confirmPassword;

  @override
  List<Object> get props => [...super.props, username, confirmPassword];
}