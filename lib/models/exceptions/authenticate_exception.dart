import 'package:equatable/equatable.dart';

sealed class AuthenticateException extends Equatable {
  const AuthenticateException(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

sealed class SignUpException extends AuthenticateException {
  const SignUpException(String message) : super(message);
}

sealed class SignInException extends AuthenticateException {
  const SignInException(String message) : super(message);
}

sealed class ResetPasswordException extends AuthenticateException {
  const ResetPasswordException(String message) : super(message);
}

// Both
class InvalidEmailException extends AuthenticateException {
  const InvalidEmailException() : super('Your email is invalid');
}

// Sign Up Exceptions

class EmailAlreadyInUseException extends SignUpException {
  const EmailAlreadyInUseException() : super('Your email is already in use');
}

class OperationNotAllowedException extends SignUpException {
  const OperationNotAllowedException()
      : super('Operation is not allowed. Please contact support');
}

class WeakPasswordException extends SignUpException {
  const WeakPasswordException() : super('Your password is too weak');
}

// Sign In Exceptions
class UserNotFoundException extends SignInException {
  const UserNotFoundException() : super('User not found');
}

class UserDisabledException extends SignInException {
  const UserDisabledException() : super('User is disabled');
}

class WrongPasswordException extends SignInException {
  const WrongPasswordException() : super('Wrong password');
}

// Reset Password Exceptions
class AuthMissingAndroidPkgNameException extends ResetPasswordException {
  const AuthMissingAndroidPkgNameException()
      : super('An Android package name must be provided if the Android app is required to be installed');
}

class AuthMissingContinueUriException extends ResetPasswordException {
  const AuthMissingContinueUriException()
      : super('A continue URL must be provided in the request');
}

class AuthMissingIosBundleIdException extends ResetPasswordException {
  const AuthMissingIosBundleIdException()
      : super('An iOS Bundle ID must be provided if an App Store ID is provided');
}

class AuthInvalidContinueUriException extends ResetPasswordException {
  const AuthInvalidContinueUriException()
      : super('The continue URL provided in the request is invalid');
}

class AuthUnauthorizedContinueUriException extends ResetPasswordException {
  const AuthUnauthorizedContinueUriException()
      : super('The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console');
}

class AuthUserNotFoundException extends ResetPasswordException {
  const AuthUserNotFoundException()
      : super('There is no user corresponding to the email address');
}

class DefaultException extends AuthenticateException {
  const DefaultException() : super('An unknown error occured');
}

class ExpiredActionCodeException extends ResetPasswordException {
  const ExpiredActionCodeException() : super('The action code has expired');
}

class InvalidActionCodeException extends ResetPasswordException {
  const InvalidActionCodeException() : super('The action code is invalid');
}

