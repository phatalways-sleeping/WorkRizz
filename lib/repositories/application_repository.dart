import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing_application/apis/apis.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';
import 'package:uuid/v8.dart';

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
  late String userId;

  Future<void> login(String email, String password) async {
    await _authenticationAPI.login(email, password).then((value) async {
      final userDataModel =
          await _storageAPI.userStreamByEmailInUser(email).first;
      userId = userDataModel.id;
      await _storageAPI.updateUserActivity(userId, true, DateTime.now());
    });
  }

  Future<void> signUp(String username, String email, String password,
      String confirmPassword) async {
    await _authenticationAPI.signUp(
      username,
      email,
      password,
      confirmPassword,
    );
    final randomAvatar = AVATARS[Random(123).nextInt(AVATARS.length)];
    userId = const UuidV8().generate();
    final newUser = UserDataModel(
      id: userId,
      imageUrl: randomAvatar,
      username: username,
      email: email,
      subTasks: const [],
      projects: const [],
      tasks: const [],
      personalSchedules: const [],
    );
    final userActivity = UserActivityModel(
      id: userId,
      isActive: true,
      lastActive: DateTime.now(),
    );

    await _storageAPI.createNewUser(newUser);
    await _storageAPI.createNewUserActivity(userActivity);
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

  Future<void> logout() async {
    userId = "";
    await _storageAPI.updateUserActivity(userId, false, DateTime.now());
    return _authenticationAPI.logout();
  }

  // Projects-Related
  Future<void> createNewProject({
    required String name,
    required String leader,
    required List<String> assignees,
    required List<String> tagsName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final tags = tagsName.map((e) => Tag(title: e)).toList();
    final projectId = const UuidV8().generate();
    final threadId = const UuidV8().generate();

    final project = Project(
      id: projectId,
      name: name,
      tasks: const [],
      tags: tags,
      startDate: startDate,
      endDate: endDate,
      leader: leader,
      assignees: assignees,
      mostActiveMemebers: const [],
      thread: threadId,
    );

    final thread = ThreadModel(id: threadId, messages: const []);

    await Future.wait<void>([
      // Create project in collection
      _storageAPI.createNewProject(project),
      // Create thread in collection
      _storageAPI.createNewThread(thread),
      // Add this project id to leader and assignees' project
      _storageAPI.updateProjectsInUser(leader, [projectId]),
      Future<void>(
        () {
          for (var assignee in assignees) {
            _storageAPI.updateProjectsInUser(assignee, [projectId]);
          }
        },
      ),
      // Archive the project setup for later usage
      _archiveLatestProjectSetup(project),
    ]);
  }

  Future<void> _archiveLatestProjectSetup(Project project) async {
    Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    await sharedPreferences.then((value) {
      value.setString("latestProjectSetup", jsonEncode(project.toJson()));
    });
  }

  Future<Project?> retrieveLatestProjectSetup() async {
    Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    late Project? project;
    await sharedPreferences.then((value) {
      if (value.containsKey("latestProjectSetup")) {
        project = Project.fromJson(
            jsonDecode(value.getString("latestProjectSetup")!)
                as Map<String, dynamic>);
      }
    });

    return project;
  }

  Stream<int> completedProjectsNumber() {
    return _storageAPI
        .userStreamByIdInUser(userId)
        .map((user) => user.completedProjects);
  }

  Stream<int> onGoingProjectsNumber() {
    return _storageAPI
        .userStreamByIdInUser(userId)
        .map((user) => user.onGoingProjects);
  }

  Stream<int> leaderProjectsNumber() {
    return _storageAPI
        .userStreamByIdInUser(userId)
        .map((user) => user.leaderProjects);
  }
}
