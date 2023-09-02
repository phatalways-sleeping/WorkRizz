import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/exceptions/authenticate_exception.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';
import 'package:uuid/v8.dart';

part 'email_password_auth.dart';
part 'google_service_auth.dart';
part 'anynomous_auth.dart';

sealed class AuthenticationAPI {
  const AuthenticationAPI();

  Future<void> login(String email, String password);

  Future<void> persistAuthenticationState(String email);

  Future<void> clearAuthenticationState();

  Future<void> signUp(
    String username,
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
