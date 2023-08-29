import 'dart:async';

sealed class AuthenticationAPI {
  const AuthenticationAPI();

  Future<void> login(String email, String password);

  Future<void> signUp(String email, String password);

  Future<void> forgotPassword(String email);

  Future<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  );

  Future<void> logout();
}

final class EmailPasswordAuthenticationAPI extends AuthenticationAPI {
  const EmailPasswordAuthenticationAPI();

  @override
  Future<void> login(String email, String password) async {}

  @override
  Future<void> signUp(String email, String password) async {}

  @override
  Future<void> forgotPassword(String email) async {}

  @override
  Future<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {}

  @override
  Future<void> logout() async {}
}

final class GoogleAuthenticationAPI extends AuthenticationAPI {
  const GoogleAuthenticationAPI();

  @override
  Future<void> login(String email, String password) async {}

  @override
  Future<void> signUp(String email, String password) async {}

  @override
  Future<void> forgotPassword(String email) async {}

  @override
  Future<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {}

  @override
  Future<void> logout() async {}
}