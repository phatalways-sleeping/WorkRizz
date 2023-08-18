import 'dart:async';

import 'package:task_managing_application/apis/apis.dart';

class AuthenticationRepository {
  const AuthenticationRepository();

  final AuthenticationAPI api = const EmailPasswordAuthenticationAPI();

  FutureOr<void> login(String email, String password) {
    return api.login(email, password);
  }

  FutureOr<void> signUp(String email, String password) {
    return api.signUp(email, password);
  }

  FutureOr<void> forgotPassword(String email) {
    return api.forgotPassword(email);
  }

  FutureOr<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) {
    return api.changePassword(email, oldPassword, newPassword);
  }

  FutureOr<void> logout() {
    return api.logout();
  }
}