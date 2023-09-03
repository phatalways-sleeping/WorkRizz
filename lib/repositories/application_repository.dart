import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing_application/apis/apis.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/models/personal_schedule/personal_schedule_model.dart';
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

  // Stream
  Stream<UserDataModel> userStream(String id) =>
      _storageAPI.userStreamByIdInUser(id);
  Stream<PersonalScheduleModel> personalScheduleStream(
          String personalScheduleId) =>
      _storageAPI.personalScheduleStreamInPersonalSchedule(personalScheduleId);
  Stream<UserActivityModel> userActivityStream(String? id) =>
      _storageAPI.userActivityStreamInUserActivity(id ?? userId);
  Stream<Project> projectStream(String id) => _storageAPI.projectStream(id);
  Stream<Task> taskStream(String taskId) => _storageAPI.taskStream(taskId);
  Stream<SubTaskModel> subTaskStream(String subTaskId) =>
      _storageAPI.subTaskModelStream(subTaskId);
  Stream<List<String>> projectInvitationStream() => _storageAPI
      .userStreamByIdInUser(userId)
      .map((event) => event.projectInvitations);
  // User Online Status
  Future<void> updateUserActivity(bool isActive) =>
      _storageAPI.updateUserActivity(
        userId,
        isActive,
        DateTime.now(),
      );
  // Project Invitation
  Future<void> acceptProjectInvitation({
    required String ofProjectId,
    required bool isLeader,
  }) async {
    await Future.wait<void>(
      [
        _storageAPI.removeProjectInvitationsInUser(userId, [ofProjectId]),
        if (isLeader) ...[
          _storageAPI.updateLeaderProjectsInUser(userId, 1),
          _storageAPI.updateLeaderInProject(ofProjectId, userId),
        ] else ...[
          _storageAPI.updateOnGoingProjectsInUser(userId, 1),
          _storageAPI.updateAssigneesInProject(ofProjectId, [userId]),
        ]
      ],
    );
  }

  Future<void> rejectProjectInvitation({
    required String ofProjectId,
    required bool isLeader,
  }) async {
    await Future.wait<void>(
      [
        _storageAPI.removeProjectInvitationsInUser(userId, [ofProjectId]),
        if (isLeader) ...[
          // _storageAPI.updateLeaderProjectsInUser(userId, 1),
          // _storageAPI.updateLeaderInProject(ofProjectId, userId),
        ] else ...[
          // _storageAPI.updateOnGoingProjectsInUser(userId, 1),
          // _storageAPI.updateAssigneesInProject(ofProjectId, [userId]),
        ]
      ],
    );
  }

  // Projects Screen
  Future<String> createNewProject({
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
      leader: "",
      leaderImageUrl: "",
      assignees: const [],
      assigneeImageUrls: const [],
      mostActiveMemebers: const [],
      thread: threadId,
    );
    final thread = ThreadModel(id: threadId, messages: const []);
    await Future.wait<void>(
      [
        // Create project in collection
        _storageAPI.createNewProject(project),
        // Create thread in collection
        _storageAPI.createNewThread(thread),
        // send invitations to leader and assignees
        _storageAPI.updateProjectInvitationsInUser(leader, [projectId]),
        Future<void>(
          () {
            for (var assignee in assignees) {
              _storageAPI.updateProjectInvitationsInUser(assignee, [projectId]);
            }
          },
        ),
        // Archive the project setup for later usage
        _archiveLatestProjectSetup(project),
      ],
    );
    return projectId;
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

  Future<String> imageUrlOnStorageOf(String path) async =>
      FirebaseFirestoreConfigs.storageRef.child(path).getDownloadURL();

  // Task / View list
  Future<void> markProjectCompleted(
    String projectId,
    List<String> assignees,
    String leader,
  ) async {
    await Future.wait<void>(
      [
        _storageAPI.updateIsCompletedInProject(projectId, true),
        Future(() {
          for (var assignee in assignees) {
            _storageAPI.updateCompletedProjectsInUser(assignee, 1);
          }
        }),
        _storageAPI.updateCompletedProjectsInUser(leader, 1),
      ],
    );
  }

  Future<void> markProjectIncompleted(
    String projectId,
    List<String> assignees,
    String leader,
  ) async {
    await Future.wait<void>(
      [
        _storageAPI.updateIsCompletedInProject(projectId, false),
        Future(() {
          for (var assignee in assignees) {
            _storageAPI.updateCompletedProjectsInUser(assignee, -1);
          }
        }),
        _storageAPI.updateCompletedProjectsInUser(leader, -1),
      ],
    );
  }

  Future<void> markSubTaskCompleted({
    required String projectId,
    required String subTaskId,
    String? taskId,
    bool markTaskCompleted = false,
  }) async {
    assert((markTaskCompleted && taskId != null) || !markTaskCompleted);
    await Future.wait<void>(
      [
        _storageAPI.updateIsCompletedInSubTask(subTaskId, true),
        _storageAPI.updateActivitiesCompletedInProject(projectId, 1),
        if (markTaskCompleted) ...[
          _storageAPI.updateTasksCompletedInProject(taskId!, 1),
          _storageAPI.updateIsCompletedInTask(taskId, true),
        ]
      ],
    );
  }

  Future<void> markSubTaskIncompleted({
    required String projectId,
    required String subTaskId,
    String? taskId,
    bool markTaskIncompleted = false,
  }) async {
    assert((markTaskIncompleted && taskId != null) || !markTaskIncompleted);
    await Future.wait<void>(
      [
        _storageAPI.updateIsCompletedInTask(subTaskId, false),
        _storageAPI.updateActivitiesCompletedInProject(projectId, -1),
        if (markTaskIncompleted) ...[
          _storageAPI.updateTasksCompletedInProject(taskId!, -1),
          _storageAPI.updateIsCompletedInTask(taskId, false),
        ]
      ],
    );
  }

  // Task / Create New Task
  Future<String> createNewSubTask({
    required String ofWhichProjectId,
    required String ofWhichTaskId,
    required String taskName,
    required String assigneeEmail,
    required String title,
    required DateTime dueDate,
    required int points,
    required String description,
    required bool needToUpdateTaskCompletion,
    required bool needToUpdateProjectCompletion,
    List<File> files = const [],
  }) async {
    final fileUrls = files.map((e) => "files/${e.path}").toList();
    for (var file in files.map(
      (e) => {
        "path": "files/${e.path}",
        "data": e,
      },
    )) {
      await FirebaseFirestoreConfigs.storageRef
          .child(file["path"] as String)
          .putFile(file["data"] as File);
    }
    final assigneeId = await _storageAPI
        .userStreamByEmailInUser(assigneeEmail)
        .first
        .then((value) => value.id);
    final newSubTask = SubTaskModel(
      id: const UuidV8().generate(),
      name: taskName,
      description: description,
      assignee: assigneeId,
      dueDate: dueDate,
      isCompleted: false,
      points: points,
      files: fileUrls,
      comments: const [],
      progress: 0.0,
      grade: 0,
      leaderComment: "",
    );
    await Future.wait<void>([
      _storageAPI.createNewSubTask(newSubTask),
      _storageAPI.updateSubTasksInTask(ofWhichTaskId, [newSubTask.id]),
      _storageAPI.updatePointsInTask(ofWhichTaskId, points),
      _storageAPI.updateTotalActivitiesInProject(ofWhichProjectId, 1),
      if (needToUpdateTaskCompletion) ...[
        _storageAPI.updateIsCompletedInTask(ofWhichTaskId, false),
      ],
      if (needToUpdateProjectCompletion) ...[
        _storageAPI.updateIsCompletedInProject(ofWhichProjectId, false),
        _storageAPI.updateCompletedProjectsInUser(userId, -1),
      ]
    ]);
    return newSubTask.id;
  }

  Future<void> removeSubTask({
    required String ofWhichProjectId,
    required String ofWhichTaskId,
    required String subTaskId,
    required String assigneeId,
    required int points,
    required bool needToUpdateTaskCompletion,
    required bool needToUpdateProjectCompletion,
  }) async {
    await Future.wait<void>([
      _storageAPI.updateTotalActivitiesInProject(ofWhichProjectId, -1),
      _storageAPI.removeSubTasksInTask(ofWhichTaskId, [subTaskId]),
      _storageAPI.updatePointsInTask(ofWhichTaskId, -points),
      if (needToUpdateTaskCompletion)
        _storageAPI.updateIsCompletedInTask(ofWhichTaskId, true),
      if (needToUpdateProjectCompletion)
        _storageAPI.updateTasksCompletedInProject(ofWhichProjectId, 1),
    ]);
  }

  // Task / Add new category
  Future<String> createNewTask({
    required String ofWhichProjectId,
    required bool needToUpdateProjectCompletion,
  }) async {
    final newTask = Task(
      id: const UuidV8().generate(),
      name: "New Category",
      subTasks: const [],
      project: ofWhichProjectId,
      points: 0,
      isCompleted: false,
    );
    await Future.wait<void>([
      _storageAPI.createNewTask(newTask),
      _storageAPI.updateTasksInProject(ofWhichProjectId, [newTask.id]),
    ]);
    return newTask.id;
  }

  Future<void> updateTaskName({
    required String taskId,
    required String taskName,
  }) async {
    await Future.wait<void>([_storageAPI.updateNameInTask(taskId, taskName)]);
  }

  // Add a person: find by email
  Future<UserDataModel> userStreamByEmail(String email) =>
      _storageAPI.userStreamByEmailInUser(email).first;

  // Task / View task
  Future<void> updateDueDateOfSubTask({
    required String subTaskId,
    required DateTime dueDate,
  }) async {
    await _storageAPI.updateDueDateInSubTask(subTaskId, dueDate);
  }

  Future<void> updatePointsOfSubTask({
    required String subTaskId,
    required int points,
  }) async {
    await _storageAPI.updatePointsInSubTask(subTaskId, points);
  }

  Future<void> updateGradeOfSubTask({
    required String subTaskId,
    required int grade,
  }) async {
    await _storageAPI.updateGradeInSubTask(subTaskId, grade);
  }

  Future<void> updateProgressOfSubTask({
    required String subTaskId,
    required double progress,
  }) async {
    await _storageAPI.updateProgressInSubTask(subTaskId, progress);
  }

  Future<void> updateDescriptionOfSubTask({
    required String subTaskId,
    required String description,
  }) async {
    await _storageAPI.updateDescriptionInSubTask(subTaskId, description);
  }

  Future<void> updateLeaderCommentOfSubTask({
    required String subTaskId,
    required String leaderComment,
  }) async {
    await _storageAPI.updateLeaderCommentInSubTask(subTaskId, leaderComment);
  }

  Future<void> createNewComment({
    required String ofWhichSubTaskId,
    required String comment,
    required String commenter,
  }) async {
    final commentModel = CommentModel(
      id: const UuidV8().generate(),
      comment: comment,
      commenter: commenter,
      date: DateTime.now(),
      solved: false,
      isReplied: false,
      replyCommentId: '',
    );
    await Future.wait<void>([
      _storageAPI.createNewComment(commentModel),
      _storageAPI.updateCommentsInSubTask(ofWhichSubTaskId, [commentModel.id]),
    ]);
  }

  Future<void> markCommentSolved({
    required String commentId,
  }) async {
    await _storageAPI.updateSolvedInComment(commentId, true);
  }

  Future<void> markCommentUnSolved({
    required String commentId,
  }) async {
    await _storageAPI.updateSolvedInComment(commentId, false);
  }

  Future<void> repliedToComment({
    required String repliedCommentId,
    required String replyingCommentId,
  }) async {
    await _storageAPI.updateIsRepliedInComment(repliedCommentId, true);
    await _storageAPI.updateReplyCommentIdInComment(
      repliedCommentId,
      replyingCommentId,
    );
  }

  // Task / View files
}
