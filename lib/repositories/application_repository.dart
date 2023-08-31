import 'dart:js_interop';

import 'package:task_managing_application/apis/apis.dart';

class ApplicationRepository {
  ApplicationRepository._({
    this.latestAuthenticatedEmail,
  });

  static void initializeRepo({String? latestAuthenticatedEmail}) {
    _instance = ApplicationRepository._(
      latestAuthenticatedEmail: latestAuthenticatedEmail,
    );
  }

  static ApplicationRepository _instance = ApplicationRepository._();

  static ApplicationRepository get repository => _instance;

  final AuthenticationAPI _authenticationAPI =
      const EmailPasswordAuthenticationAPI();
  final StorageAPI _storageAPI = const CloudFirestoreStorageAPI();

  String? latestAuthenticatedEmail;

  Future<void> login(String email, String password) {
    return _authenticationAPI.login(email, password);
  }

  Future<void> signUp(
    String email,
    String password,
    String confirmPassword,
  ) {
    return _authenticationAPI.signUp(
      email,
      password,
      confirmPassword,
    );
  }

  Future<void> forgotPassword(String email) {
    return _authenticationAPI.forgotPassword(email);
  }

  Future<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) {
    return _authenticationAPI.changePassword(email, newPassword);
  }

  Future<void> logout() {
    return _authenticationAPI.logout();
  }

  Future<void> findTask() {
    return _storageAPI.findTask();
  }

  Future<void> findUser() {
    return _storageAPI.findUser();
  }

  Future<void> findProject() {
    return _storageAPI.findProject();
  }

  Future<void> findTeam() {
    return _storageAPI.findTeam();
  }
}
