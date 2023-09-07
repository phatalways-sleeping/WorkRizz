import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing_application/apis/apis.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/assets/config/firebase_firestore_configs.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/models/personal_schedule/personal_schedule_model.dart';
import 'package:task_managing_application/models/project_invitation/project_invitation.dart';
import 'package:task_managing_application/models/task/sub_task_small_info.dart';
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
  late String userEmailAddress;
  late String userImageUrl;
  late String username;

  late String projectIdOnView;
  late String projectOnViewName;
  late bool isLeaderOfProjectOnView;
  late String subTaskIdOnView;
  late String taskIdOnView;

  Future<void> login(String email, String password) async {
    await _authenticationAPI.login(email, password).then((value) async {
      final userDataModel =
          await _storageAPI.userStreamByEmailInUser(email).first;
      userId = userDataModel.id;
      userImageUrl = userDataModel.imageUrl;
      userEmailAddress = email;
      username = userDataModel.username;
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
    userImageUrl = randomAvatar;
    userEmailAddress = email;
    this.username = username;

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
    userImageUrl = "";
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
  Stream<Project> projectOnViewStream() =>
      _storageAPI.projectStream(projectIdOnView);
  Stream<Task> taskStream(String taskId) => _storageAPI.taskStream(taskId);
  Stream<SubTaskModel> subTaskStream({String? subTaskId}) =>
      _storageAPI.subTaskModelStream(subTaskId ?? subTaskIdOnView);
  Stream<List<String>> get projectInvitationsStreamInUser => _storageAPI
      .userStreamByIdInUser(userId)
      .map((event) => event.projectInvitations);
  Stream<ProjectInvitationModel> projectInvitationStream(
          String projectInvitationId) =>
      _storageAPI.projectInvitationStream(projectInvitationId);
  Stream<CommentModel> commentStream(String commentId) =>
      _storageAPI.commentStream(commentId);
  // Future
  Future<String> currentUserImageUrl() async => await _storageAPI
      .userStreamByIdInUser(userId)
      .first
      .then((value) => value.imageUrl)
      .onError((error, stackTrace) => "avatars/avatar_1.png");
  // User Online Status
  Future<void> updateUserActivity(bool isActive) =>
      _storageAPI.updateUserActivity(
        userId,
        isActive,
        DateTime.now(),
      );
  // Project Invitation
  Future<void> acceptProjectInvitation({
    required String projectInvitationId,
  }) async {
    final invitation =
        await _storageAPI.projectInvitationStream(projectInvitationId).first;

    await Future.wait<void>(
      [
        _storageAPI.removeProjectInvitationsInUser(
          userId,
          [projectInvitationId],
        ),
        _storageAPI.updateOnGoingProjectsInUser(userId, 1),
        _storageAPI.updateIsAcceptedInProjectInvitation(
            projectInvitationId, true),
        _storageAPI.updateProjectsInUser(userId, [invitation.projectId]),
        if (invitation.projectLeaderId == userId) ...[
          _storageAPI.updateLeaderProjectsInUser(userId, 1),
        ]
      ],
    );
  }

  Future<void> rejectProjectInvitation({
    required String projectInvitationId,
  }) async {
    late String creatorId;
    late String creatorImageUrl;
    final invitation =
        await _storageAPI.projectInvitationStream(projectInvitationId).first;
    if (invitation.projectLeaderId == userId) {
      creatorId = await _storageAPI
          .projectStream(invitation.projectId)
          .first
          .then((value) => value.creatorId)
          .onError((error, stackTrace) => "");
      creatorImageUrl = await _storageAPI
          .userStreamByIdInUser(creatorId)
          .first
          .then((value) => value.imageUrl)
          .onError((error, stackTrace) => '');
    }
    await Future.wait<void>(
      [
        _storageAPI.removeProjectInvitationsInUser(userId, [invitation.id]),
        _storageAPI.updateIsAcceptedInProjectInvitation(
            projectInvitationId, false),
        if (invitation.projectLeaderId == userId) ...[
          _storageAPI.updateLeaderInProject(
            invitation.projectId,
            creatorId,
          ),
          _storageAPI.updateLeaderImageUrlInProject(
            invitation.projectId,
            creatorImageUrl,
          ),
          _storageAPI.updateLeaderProjectsInUser(creatorId, 1),
          _storageAPI
              .removeAssigneesInProject(invitation.projectId, [creatorId]),
          _storageAPI.removeAssigneeImageUrlsInProject(
            invitation.projectId,
            [creatorImageUrl],
          )
        ] else ...[
          _storageAPI.removeAssigneesInProject(invitation.projectId, [userId]),
          _storageAPI.removeAssigneeImageUrlsInProject(
            invitation.projectId,
            [userImageUrl],
          )
        ]
      ],
    );
  }

  // Projects Screen
  Project createDefaultProjectSetup() {
    final newProject = Project(
      id: const UuidV8().generate(),
      name: "",
      tasks: const [],
      tags: const [],
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      leader: userId,
      creatorId: userId,
      leaderImageUrl: userImageUrl,
      assignees: const [],
      assigneeImageUrls: const [],
      mostActiveMemebers: const [],
      thread: const UuidV8().generate(),
    );
    return newProject;
  }

  Future<void> createNewProject({
    required Project newSetupProject,
  }) async {
    if (newSetupProject.creatorId != userId) {
      newSetupProject = newSetupProject.copyWith(
        creatorId: userId,
      );
    }
    if (newSetupProject.leader != userId) {
      // if the user is not the leader
      // get the leader's email and username
      // create an invitation for the leader
      final projectLeaderInvitation = ProjectInvitationModel(
        id: const UuidV8().generate(),
        projectId: newSetupProject.id,
        projectName: newSetupProject.name,
        projectLeaderId: newSetupProject.leader,
        projectLeaderImageUrl: newSetupProject.leaderImageUrl,
        senderEmail: userEmailAddress,
        senderId: userId,
        senderImageUrl: userImageUrl,
        senderUsername: username,
        receiverId: newSetupProject.leader,
      );
      // update the leader's project invitations
      // and create the invitation in the collection
      await Future.wait<void>(
        [
          _storageAPI.createNewProjectInvitation(projectLeaderInvitation),
          _storageAPI.updateProjectInvitationsInUser(
            newSetupProject.leader,
            [projectLeaderInvitation.id],
          ),
        ],
      );
    } else {
      // if the user is the leader
      await Future.wait<void>(
        [
          _storageAPI.updateOnGoingProjectsInUser(userId, 1),
          _storageAPI.updateLeaderProjectsInUser(userId, 1),
          _storageAPI.updateProjectsInUser(userId, [newSetupProject.id]),
        ],
      );
    }
    // if user is in the assignees list
    if (newSetupProject.assignees.contains(userId)) {
      await Future.wait<void>(
        [
          _storageAPI.updateOnGoingProjectsInUser(userId, 1),
          _storageAPI.updateProjectsInUser(userId, [newSetupProject.id]),
        ],
      );
    }
    final projectInvitations = newSetupProject.assignees
        .where((element) => element != userId) // remove the user
        .map(
          (e) => ProjectInvitationModel(
            id: const UuidV8().generate(),
            projectId: newSetupProject.id,
            projectName: newSetupProject.name,
            projectLeaderId: newSetupProject.leader,
            projectLeaderImageUrl: newSetupProject.leaderImageUrl,
            senderEmail: userEmailAddress,
            senderId: userId,
            senderImageUrl: userImageUrl,
            senderUsername: username,
            receiverId: e,
          ),
        )
        .toList();
    await Future.wait<void>(
      [
        // Create project in collection
        _storageAPI.createNewProject(newSetupProject),
        // Create thread in collection
        _storageAPI.createNewThread(
          ThreadModel(
            id: newSetupProject.thread,
            messages: const [],
          ),
        ),
        // send invitations to assignees
        Future<void>(
          () {
            for (var invitation in projectInvitations) {
              _storageAPI.createNewProjectInvitation(invitation);
              _storageAPI.updateProjectInvitationsInUser(
                invitation.receiverId,
                [invitation.id],
              );
            }
          },
        ),
        // Archive the project setup for later usage
        _archiveLatestProjectSetup(newSetupProject),
      ],
    );
  }

  Future<void> _archiveLatestProjectSetup(Project project) async {
    Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    await sharedPreferences.then(
      (value) {
        value.setString("latestProjectSetup", jsonEncode(project.toJson()));
      },
    ).onError(
      (error, stackTrace) {},
    );
  }

  Future<Project?> retrieveLatestProjectSetup() async {
    Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    Project? project;
    await sharedPreferences.then(
      (value) {
        if (value.containsKey("latestProjectSetup")) {
          project = Project.fromJson(
              jsonDecode(value.getString("latestProjectSetup")!)
                  as Map<String, dynamic>);
        }
      },
    );

    return project?.copyWith(
      id: const UuidV8().generate(),
      thread: const UuidV8().generate(),
    );
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
        for (var assignee in assignees)
          _storageAPI.updateCompletedProjectsInUser(assignee, 1),
        for (var assignee in assignees)
          _storageAPI.updateOnGoingProjectsInUser(assignee, -1),
        _storageAPI.updateCompletedProjectsInUser(leader, 1),
        _storageAPI.updateOnGoingProjectsInUser(leader, -1),
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
        for (var assignee in assignees)
          _storageAPI.updateCompletedProjectsInUser(assignee, -1),
        for (var assignee in assignees)
          _storageAPI.updateOnGoingProjectsInUser(assignee, 1),
        _storageAPI.updateCompletedProjectsInUser(leader, -1),
        _storageAPI.updateOnGoingProjectsInUser(leader, 1),
      ],
    );
  }

  Future<void> markSubTaskCompleted({
    required String subTaskId,
    required String taskId,
  }) async {
    await Future.wait<void>(
      [
        _storageAPI.updateIsCompletedInSubTask(subTaskId, true),
        _storageAPI.updateActivitiesCompletedInProject(projectIdOnView, 1),
        _storageAPI.updateSubTasksCompletedInTask(taskId, 1),
      ],
    );

    final subTask = await _storageAPI.subTaskModelStream(subTaskId).first;

    final assigneeImageUrl = await _storageAPI
        .userStreamByIdInUser(subTask.assignee)
        .first
        .then((value) => value.imageUrl);

    final subTaskInformation = SubTaskSmallInformation(
      id: subTaskId,
      name: subTask.name,
      isCompleted: false,
      points: subTask.points,
      assigneeImageUrl: assigneeImageUrl,
    );

    await _storageAPI.removeSubTaskSmallInformationsInTask(taskId, [
      subTaskInformation,
    ]);

    await _storageAPI.updateSubTaskSmallInformationsInTask(taskId, [
      subTaskInformation.copyWith(
        isCompleted: true,
      ),
    ]);

    final task = await _storageAPI.taskStream(taskId).first;

    if (task.subTasksCompleted == task.subTasks.length) {
      await Future.wait<void>([
        _storageAPI.updateIsCompletedInTask(taskId, true),
        _storageAPI.updateTasksCompletedInProject(projectIdOnView, 1),
      ]);
    }
  }

  Future<void> markSubTaskUnCompleted({
    required String subTaskId,
    required String taskId,
  }) async {
    final subTask = await _storageAPI.subTaskModelStream(subTaskId).first;

    final assigneeImageUrl = await _storageAPI
        .userStreamByIdInUser(subTask.assignee)
        .first
        .then((value) => value.imageUrl);

    final subTaskInformation = SubTaskSmallInformation(
      id: subTaskId,
      name: subTask.name,
      isCompleted: true,
      points: subTask.points,
      assigneeImageUrl: assigneeImageUrl,
    );
    await _storageAPI.removeSubTaskSmallInformationsInTask(taskId, [
      subTaskInformation,
    ]);
    await _storageAPI.updateSubTaskSmallInformationsInTask(taskId, [
      subTaskInformation.copyWith(
        isCompleted: false,
      ),
    ]);
    await Future.wait<void>(
      [
        _storageAPI.updateSubTasksCompletedInTask(taskId, -1),
        _storageAPI.updateIsCompletedInSubTask(subTaskId, false),
        _storageAPI.updateActivitiesCompletedInProject(projectIdOnView, -1),
      ],
    );
    final taskIsCompleted = await _storageAPI.taskStream(taskId).first.then(
          (value) => value.isCompleted,
        );
    if (taskIsCompleted) {
      await Future.wait<void>([
        _storageAPI.updateIsCompletedInTask(taskId, false),
        _storageAPI.updateTasksCompletedInProject(projectIdOnView, -1),
      ]);
    }
  }

  // Task / Create New Task
  Future<List<File>> pickFiles() async {
    return await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        "pdf",
        "docx",
        "csv",
        "pptx",
        'jpg',
        'jpeg',
        'png',
        'gif',
        'mp4',
        'mov',
        'avi',
        'mp3',
        'txt',
      ],
    ).then((value) {
      if (value != null) {
        return value.paths.map((path) => File(path!)).toList();
      } else {
        return <File>[];
      }
    }).onError((error, stackTrace) {
      return <File>[];
    });
  }

  Future<void> createNewSubTask({
    required SubTaskModel newSubTask,
    required List<File> files,
  }) async {
    final fileUrls =
        files.map((e) => "files/${e.path.split('/').last}").toList();
    newSubTask.copyWith(
      files: fileUrls,
    );
    debugPrint(newSubTask.assignee);
    for (var file in files.map(
      (e) => {
        "path": "files/${e.path.split('/').last}",
        "data": e,
      },
    )) {
      await FirebaseFirestoreConfigs.storageRef
          .child(file["path"] as String)
          .putFile(file["data"] as File);
    }
    final assigneeImageUrl =
        await _storageAPI.userStreamByIdInUser(newSubTask.assignee).first.then(
              (value) => value.imageUrl,
            );
    final subTaskSmallInformation = SubTaskSmallInformation(
      id: newSubTask.id,
      name: newSubTask.name,
      isCompleted: false,
      points: newSubTask.points,
      assigneeImageUrl: assigneeImageUrl,
    );
    final needToUpdateTaskCompletion = await _storageAPI
        .taskStream(taskIdOnView)
        .first
        .then((value) => value.isCompleted);
    await Future.wait<void>(
      [
        _storageAPI.createNewSubTask(
          newSubTask,
        ),
        _storageAPI.updateSubTaskSmallInformationsInTask(
          taskIdOnView,
          [
            subTaskSmallInformation,
          ],
        ),
        _storageAPI.updateSubTasksInTask(taskIdOnView, [newSubTask.id]),
        _storageAPI.updatePointsInTask(taskIdOnView, newSubTask.points),
        _storageAPI.updateTotalActivitiesInProject(projectIdOnView, 1),
        _storageAPI.updateSubTasksInUser(newSubTask.assignee, [newSubTask.id]),
        if (needToUpdateTaskCompletion) ...[
          _storageAPI.updateIsCompletedInTask(taskIdOnView, false),
          _storageAPI.updateTasksCompletedInProject(projectIdOnView, -1),
        ],
      ],
    );
  }

  Future<void> removeSubTask({
    required String projectId,
    required String taskId,
    required String subTaskId,
    required bool needToUpdateTaskCompletion,
  }) async {
    final subTask = await _storageAPI.subTaskModelStream(subTaskId).first;
    final subTaskInformation = await _storageAPI.taskStream(taskId).first.then(
          (value) => value.subTaskSmallInformations.where(
            (element) => element.id == subTaskId,
          ),
        );
    final subTaskSmallInformationTrue = SubTaskSmallInformation(
      id: subTaskId,
      name: subTask.name,
      isCompleted: true,
      points: subTask.points,
      assigneeImageUrl: subTaskInformation.first.assigneeImageUrl,
    );
    final subTaskSmallInformationFalse = SubTaskSmallInformation(
      id: subTaskId,
      name: subTask.name,
      isCompleted: false,
      points: subTask.points,
      assigneeImageUrl: subTaskInformation.first.assigneeImageUrl,
    );

    await Future.wait<void>(
      [
        _storageAPI.removeSubTaskSmallInformationsInTask(taskId, [
          subTaskSmallInformationTrue,
          subTaskSmallInformationFalse,
        ]),
        _storageAPI.updateTotalActivitiesInProject(projectId, -1),
        _storageAPI.removeSubTasksInTask(taskId, [subTaskId]),
        _storageAPI.updatePointsInTask(taskId, -subTask.points),
        if (needToUpdateTaskCompletion) ...[
          _storageAPI.updateIsCompletedInTask(taskId, true),
          _storageAPI.updateTasksCompletedInProject(projectId, 1),
        ],
      ],
    );
  }

  Future<void> updateFilesWithoutOverridePermissionToSubTask({
    required List<File> files,
  }) async {
    final fileUrls =
        files.map((e) => "files/${e.path.split('/').last}").toList();
    final currentFileUrls = await _storageAPI
        .subTaskModelStream(subTaskIdOnView)
        .first
        .then((value) => value.files);
    final needToUpdateFileUrls = fileUrls
        .where((element) => !currentFileUrls.contains(element))
        .toList();
    final needToUpdateFiles = files
        .where((element) => needToUpdateFileUrls
            .contains('files/${element.path.split('/').last}'))
        .toList();

    for (var file in needToUpdateFiles.map(
      (e) => {
        "path": "files/${e.path.split('/').last}",
        "data": e,
      },
    )) {
      await FirebaseFirestoreConfigs.storageRef
          .child(file["path"] as String)
          .putFile(file["data"] as File);
    }

    await Future.wait<void>(
      [
        _storageAPI.updateFilesInSubTask(subTaskIdOnView, needToUpdateFileUrls),
      ],
    );
  }

  Future<void> updateFilesWithOverridePermissionToSubTask({
    required List<File> files,
  }) async {
    final fileUrls =
        files.map((e) => "files/${e.path.split('/').last}").toList();
    for (var file in files.map(
      (e) => {
        "path": "files/${e.path.split('/').last}",
        "data": e,
      },
    )) {
      await FirebaseFirestoreConfigs.storageRef
          .child(file["path"] as String)
          .putFile(file["data"] as File);
    }
    await Future.wait<void>(
      [
        _storageAPI.updateFilesInSubTask(subTaskIdOnView, fileUrls),
      ],
    );
  }

  Future<void> removeFilesFromSubTask({
    required List<String> fileUrls,
  }) async {
    await Future.wait<void>(
      [
        for (var fileUrl in fileUrls)
          FirebaseFirestoreConfigs.storageRef.child(fileUrl).delete(),
        _storageAPI.removeFilesInSubTask(subTaskIdOnView, fileUrls),
      ],
    );
  }

  // Task / Add new category
  Future<void> createNewTask({
    required String name,
  }) async {
    final newTask = Task(
      id: const UuidV8().generate(),
      name: name,
      subTasks: const [],
      project: projectIdOnView,
      points: 0,
      isCompleted: false,
    );
    await Future.wait<void>(
      [
        _storageAPI.createNewTask(newTask),
        _storageAPI.updateTasksInProject(
          projectIdOnView,
          [
            newTask.id,
          ],
        ),
      ],
    );
  }

  Future<void> updateTaskName({
    required String taskId,
    required String taskName,
  }) async {
    await Future.wait<void>([_storageAPI.updateNameInTask(taskId, taskName)]);
  }

  // Add a person: find by email
  Stream<UserDataModel> userStreamByEmail(String email) =>
      _storageAPI.userStreamByEmailInUser(email);

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
    required String comment,
  }) async {
    final commentModel = CommentModel(
      id: const UuidV8().generate(),
      comment: comment,
      commenter: userId,
      date: DateTime.now(),
      solved: false,
      isReplied: false,
      repliedToUsername: username,
    );
    await Future.wait<void>([
      _storageAPI.createNewComment(commentModel),
      _storageAPI.updateCommentsInSubTask(subTaskIdOnView, [commentModel.id]),
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
    required String repliedToUsername,
    required String message,
  }) async {
    final commentModel = CommentModel(
      id: const UuidV8().generate(),
      comment: message,
      commenter: userId,
      date: DateTime.now(),
      solved: false,
      isReplied: true,
      repliedToUsername: repliedToUsername,
    );

    debugPrint(commentModel.toString());
    await Future.wait<void>(
      [
        _storageAPI.updateIsRepliedInComment(repliedCommentId, false),
        _storageAPI.createNewComment(commentModel),
        _storageAPI.updateCommentsInSubTask(subTaskIdOnView, [commentModel.id]),
      ],
    );
  }

  Future<void> removeCommentOutOfSubTask({required String commentId}) async {
    await Future.wait<void>([
      _storageAPI.removeCommentsInSubTask(subTaskIdOnView, [commentId]),
      _storageAPI.deleteComment(commentId),
    ]);
  }

  Future<void> updateRemainingOfSubTask({
    required String description,
    required DateTime dueDate,
    required int points,
    required int grade,
    required double progress,
    required String leaderComment,
    required int oldPoints,
    required bool isCompleted,
  }) async {
    final task = await _storageAPI.taskStream(taskIdOnView).first;
    final subTaskCompleted = await _storageAPI
        .subTaskModelStream(subTaskIdOnView)
        .first
        .then((value) => value.isCompleted);
    final subTaskSmallInformation = task.subTaskSmallInformations
        .where((element) => element.id == subTaskIdOnView);
    await Future.wait<void>(
      [
        _storageAPI.updateDescriptionInSubTask(subTaskIdOnView, description),
        _storageAPI.updateDueDateInSubTask(subTaskIdOnView, dueDate),
        _storageAPI.updateGradeInSubTask(subTaskIdOnView, grade),
        if (oldPoints != points) ...[
          _storageAPI.updatePointsInSubTask(subTaskIdOnView, points),
          _storageAPI.updatePointsInTask(taskIdOnView, points - oldPoints),
          _storageAPI.removeSubTaskSmallInformationsInTask(
              taskIdOnView, [subTaskSmallInformation.first]),
          _storageAPI.updateSubTaskSmallInformationsInTask(
            taskIdOnView,
            [
              subTaskSmallInformation.first.copyWith(
                points: points,
              ),
            ],
          ),
        ],
        _storageAPI.updateProgressInSubTask(subTaskIdOnView, progress),
        _storageAPI.updateLeaderCommentInSubTask(
          subTaskIdOnView,
          leaderComment,
        ),
        if (isCompleted && !subTaskCompleted)
          markSubTaskCompleted(
            subTaskId: subTaskIdOnView,
            taskId: taskIdOnView,
          )
        else if (!isCompleted && subTaskCompleted)
          markSubTaskUnCompleted(
            subTaskId: subTaskIdOnView,
            taskId: taskIdOnView,
          )
      ],
    ).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      return [];
    });
  }
  // Task / View files

  // Thread / View thread
  Future<void> addNewMessage({
    required String threadId,
    required String message,
    required bool isTextMessage,
    required bool isImageMessage,
    File? image,
    File? file,
  }) async {
    if (isTextMessage) {
      final newMessage = TextMessageModel(
        id: const UuidV8().generate(),
        sender: userId,
        time: DateTime.now(),
        text: message,
      );

      await Future.wait<void>([
        _storageAPI.createNewMessage(newMessage),
        _storageAPI.updateMessagesInThread(threadId, [newMessage.id]),
      ]);
    } else if (isImageMessage) {
      assert(image != null);
      final newMessage = ImageMessageModel(
        id: const UuidV8().generate(),
        sender: userId,
        time: DateTime.now(),
        imageUrl: "images/${image!.path}",
      );

      await Future.wait<void>([
        _storageAPI.createNewMessage(newMessage),
        _storageAPI.updateMessagesInThread(threadId, [newMessage.id]),
        _storageAPI.updateImageToStorage(image: image),
      ]);
    } else {
      assert(file != null);
      final fileTypeString = file!.path.split(".").last;
      final fileType = fileTypeString == "pdf"
          ? FileTypeMode.pdf
          : fileTypeString == "docx"
              ? FileTypeMode.doc
              : fileTypeString == "csv"
                  ? FileTypeMode.csv
                  : fileTypeString == "pptx"
                      ? FileTypeMode.ppt
                      : FileTypeMode.other;

      final newMessage = FileMessageModel(
        id: const UuidV8().generate(),
        sender: userId,
        time: DateTime.now(),
        fileUrl: "files/${file.path}",
        fileName: file.path.split("/").last,
        fileType: fileType,
      );

      await Future.wait<void>([
        _storageAPI.createNewMessage(newMessage),
        _storageAPI.updateMessagesInThread(threadId, [newMessage.id]),
        _storageAPI.updateFileToStorage(file: file),
      ]);
    }
  }

  Future<File> downloadFile(String fileUrl) async =>
      await _storageAPI.fileFromStorage(fileUrl);

  Future<File> downloadImage(String imageUrl) async =>
      await _storageAPI.imageFileFromStorage(imageUrl);
}
