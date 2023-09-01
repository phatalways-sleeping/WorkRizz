part of 'authentication_api.dart';

final class EmailPasswordAuthenticationAPI extends AuthenticationAPI {
  const EmailPasswordAuthenticationAPI();

  @override
  Future<void> login(String email, String password) async {
    if (email.isEmpty || !email.contains("@") || !email.contains(".")) {
      throw const InvalidEmailException();
    }
    if (password.isEmpty) {
      throw const InvalidPasswordException("Password cannot be empty");
    }
    if (password.length < 6) {
      throw const InvalidPasswordException(
          "Password must be at least 6 characters");
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async => persistAuthenticationState(email));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw const UserNotFoundException();
        case 'wrong-password':
          throw const WrongPasswordException();
        case 'user-disabled':
          throw const UserDisabledException();
        default:
          throw const DefaultException();
      }
    }
  }

  @override
  Future<void> signUp(
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (email.isEmpty || !email.contains("@") || !email.contains(".")) {
      throw const InvalidEmailException();
    }
    if (password.isEmpty) {
      throw const InvalidPasswordException("Password cannot be empty");
    }
    if (password.length < 6) {
      throw const InvalidPasswordException(
          "Password must be at least 6 characters");
    }
    if (password != confirmPassword) {
      throw const ConfirmPasswordException();
    }

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) async => persistAuthenticationState(email));
      final randomAvatar = AVATARS[Random(123).nextInt(AVATARS.length)];
      final newUser = UserDataModel(
        id: const UuidV8().generate(),
        imageUrl: randomAvatar,
        username: username,
        email: email,
        subTasks: const [],
        projects: const [],
        tasks: const [],
        personalSchedules: const [],
      );

      final userActivity = UserActivityModel(
        id: newUser.id,
        isActive: true,
        lastActive: DateTime.now(),
      );

      await FirebaseFirestoreConfigs.usersCollection
          .doc(newUser.id)
          .set(newUser.toJson());

      await FirebaseFirestoreConfigs.userActivitiesCollection
          .doc(userActivity.id)
          .set(userActivity.toJson());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw const EmailAlreadyInUseException();
        case 'operation-not-allowed':
          throw const OperationNotAllowedException();
        case 'weak-password':
          throw const WeakPasswordException();
        default:
          throw const DefaultException();
      }
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    if (email.isEmpty || !email.contains("@") || !email.contains(".")) {
      throw const InvalidEmailException();
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'auth/invalid-email':
          throw const InvalidEmailException();
        case 'auth/user-not-found':
          throw const UserNotFoundException();
        case 'auth/unauthorized-continue-uri':
          throw const AuthUnauthorizedContinueUriException();
        case 'auth/invalid-continue-uri':
          throw const AuthInvalidContinueUriException();
        case 'auth/missing-ios-bundle-id':
          throw const AuthMissingIosBundleIdException();
        case 'auth/missing-continue-uri':
          throw const AuthMissingContinueUriException();
        case 'auth/missing-android-pkg-name':
          throw const AuthMissingAndroidPkgNameException();
        default:
          throw const DefaultException();
      }
    }
  }

  @override
  Future<void> changePassword(
    String email,
    String newPassword,
  ) async {
    if (newPassword.isEmpty) {
      throw const InvalidPasswordException("Password cannot be empty");
    }
    if (newPassword.length < 6) {
      throw const InvalidPasswordException(
          "Password must be at least 6 characters");
    }

    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user != null) {
          await user.updatePassword(newPassword);
        }
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw const WeakPasswordException();
        case 'requires-recent-login':
          throw const RequireRecentLogin();
        default:
          throw const DefaultException();
      }
    }
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    clearAuthenticationState();
  }

  @override
  Future<void> persistAuthenticationState(String email) async {
    Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    await sharedPreferences.then(
      (value) {
        value.setBool('hasBeenAuthenticated', true);
        value.setString('email', email);
      },
    );
  }

  @override
  Future<void> clearAuthenticationState() async {
    Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    await sharedPreferences.then((value) {
      value.setBool('hasBeenAuthenticated', false);
      value.remove('email');
    });
  }
}
