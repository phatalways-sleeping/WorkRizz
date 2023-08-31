import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing_application/models/exceptions/authenticate_exception.dart';

part 'email_password_auth.dart';
part 'google_service_auth.dart';
part 'anynomous_auth.dart';

sealed class AuthenticationAPI {
  const AuthenticationAPI();

  Future<void> login(String email, String password);

  Future<void> signUp(
    String email,
    String password,
    String confirmPassword,
  );

  Future<void> forgotPassword(String email);

  Future<void> changePassword(
    String email,
    String newPassword,
  );

  Future<void> logout();
}

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  logout,
  unknown,
}
