part of 'authentication_api.dart';

final class GoogleAuthenticationAPI extends AuthenticationAPI {
  const GoogleAuthenticationAPI();

  @override
  Future<void> login(String email, String password) async {}

  @override
  Future<void> signUp(
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {}

  @override
  Future<void> forgotPassword(String email) async {}

  @override
  Future<void> changePassword(
    String email,
    String newPassword,
  ) async {}

  @override
  Future<void> logout() async {}

  @override
  Future<void> persistAuthenticationState(String email) async {}

  @override
  Future<void> clearAuthenticationState() async {}
}
