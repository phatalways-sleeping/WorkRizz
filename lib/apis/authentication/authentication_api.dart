import 'dart:async';

sealed class AuthenticationAPI {
  const AuthenticationAPI();

  FutureOr<void> login(String email, String password);

  FutureOr<void> signUp(String email, String password);

  FutureOr<void> forgotPassword(String email);

  FutureOr<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  );

  FutureOr<void> logout();
}

final class EmailPasswordAuthenticationAPI extends AuthenticationAPI {
  const EmailPasswordAuthenticationAPI();

  @override
  FutureOr<void> login(String email, String password) {}

  @override
  FutureOr<void> signUp(String email, String password) {}

  @override
  FutureOr<void> forgotPassword(String email) {}

  @override
  FutureOr<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) {}

  @override
  FutureOr<void> logout() {}
}

final class GoogleAuthenticationAPI extends AuthenticationAPI {
  const GoogleAuthenticationAPI();

  @override
  FutureOr<void> login(String email, String password) {}

  @override
  FutureOr<void> signUp(String email, String password) {}

  @override
  FutureOr<void> forgotPassword(String email) {}

  @override
  FutureOr<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) {}

  @override
  FutureOr<void> logout() {}
}