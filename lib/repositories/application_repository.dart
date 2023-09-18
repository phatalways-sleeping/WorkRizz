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
import 'package:task_managing_application/models/file/file_model.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/models/personal_schedule/personal_schedule_model.dart';
import 'package:task_managing_application/models/project/files_small_info.dart';
import 'package:task_managing_application/models/project/task_small_info.dart';
import 'package:task_managing_application/models/project_invitation/project_invitation.dart';
import 'package:task_managing_application/models/project/sub_task_small_info.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';
import 'package:uuid/v8.dart';

class ApplicationRepository {
  ApplicationRepository._();

  static void initializeRepo({
    UserDataModel? userAccount,
  }) {
    _instance = ApplicationRepository._();
    if (userAccount != null) {
      _instance.userId = userAccount.id;
      _instance.userEmailAddress = userAccount.email;
      _instance.userImageUrl = userAccount.imageUrl;
      _instance.username = userAccount.username;
    }
  }

  static ApplicationRepository _instance = ApplicationRepository._();
  static ApplicationRepository get repository => _instance;

  final AuthenticationAPI _authenticationAPI =
      const EmailPasswordAuthenticationAPI();
  final StorageAPI _storageAPI = const CloudFirestoreStorageAPI();

  late String userId;
  late String userEmailAddress;
  late String userImageUrl;
  late String username;

  late String projectIdOnView;
  late String threadIdOnView;
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

    await SharedPreferences.getInstance().then((value) {
      value.setString('userEmailAddress', email);
      value.setString('userImageUrl', userImageUrl);
      value.setString('username', username);
      value.setString('userId', userId);
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
    final randomAvatar = AVATARS[Random().nextInt(AVATARS.length)];

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
    await SharedPreferences.getInstance().then((value) {
      value.setString('userEmailAddress', email);
      value.setString('userImageUrl', userImageUrl);
      value.setString('username', username);
      value.setString('userId', userId);
    });
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
    await _storageAPI.updateUserActivity(userId, false, DateTime.now());
    await SharedPreferences.getInstance().then((value) {
      value.setString('userEmailAddress', "");
      value.setString('userImageUrl', "");
      value.setString('username', "");
      value.setString('userId', "");
      userId = "";
      userEmailAddress = "";
      userImageUrl = "";
      username = "";
    });

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
  Stream<ThreadModel> threadStream() =>
      _storageAPI.threadStream(threadIdOnView);
  Future<MessageModel> messageStream(String messageId) =>
      _storageAPI.messageStream(messageId).first;
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
    // Find and remove all sub tasks of the user relating to the project
    final subTasksOfUser = await _storageAPI
        .userStreamByIdInUser(userId)
        .first
        .then((value) => value.subTasks)
        .onError((error, stackTrace) => []);
    final project = await _storageAPI.projectStream(invitation.projectId).first;
    final subTasksToRemove = <String, List<String>>{};
    for (var task in project.taskSmallInformations) {
      for (var subTask in task.subTaskSmallInformations) {
        if (subTasksOfUser.contains(subTask.id)) {
          if (subTasksToRemove.containsKey(task.id)) {
            subTasksToRemove[task.id]!.add(subTask.id);
          } else {
            subTasksToRemove[task.id] = [subTask.id];
          }
        }
      }
    }
    await Future.wait<void>([
      for (var task in subTasksToRemove.keys) ...[
        // delete each sub task
        for (var subTask in subTasksToRemove[task]!)
          deleteSubTask(taskId: task, subTaskId: subTask),
      ],
    ]);
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
  Project createDefaultProjectSetup() => Project(
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
        taskSmallInformations: const [],
        isCompleted: false,
        tasksCompleted: 0,
        activitiesCompleted: 0,
        totalActivities: 0,
        totalFileLinks: 0,
        thread: const UuidV8().generate(),
      );

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
      isCompleted: true,
      points: subTask.points,
      assigneeImageUrl: assigneeImageUrl,
    );

    final taskSmallInformations = await _storageAPI
        .projectStream(projectIdOnView)
        .first
        .then((value) => value.taskSmallInformations);

    final taskSmallInformation = taskSmallInformations.firstWhere(
      (element) => element.id == taskId,
    );

    final newTaskInformation = taskSmallInformation.copyWith(
      subTaskSmallInformations: [
        ...taskSmallInformation.subTaskSmallInformations
            .where((element) => element.id != subTaskId),
        subTaskInformation,
      ],
    );

    // Update the task small information in project
    await Future.wait<void>([
      _storageAPI.removeTaskSmallInformationsInProject(projectIdOnView, [
        taskSmallInformation,
      ]),
      _storageAPI.updateTaskSmallInformationsInProject(
        projectIdOnView,
        [newTaskInformation],
      ),
    ]);

    debugPrint("Subtask completed");

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
      isCompleted: false,
      points: subTask.points,
      assigneeImageUrl: assigneeImageUrl,
    );

    final taskSmallInformations = await _storageAPI
        .projectStream(projectIdOnView)
        .first
        .then((value) => value.taskSmallInformations);

    final taskSmallInformation = taskSmallInformations.firstWhere(
      (element) => element.id == taskId,
    );

    final newTaskInformation = taskSmallInformation.copyWith(
      subTaskSmallInformations: [
        ...taskSmallInformation.subTaskSmallInformations
            .where((element) => element.id != subTaskId),
        subTaskInformation,
      ],
    );

    // Update the task small information in project
    await Future.wait<void>([
      _storageAPI.removeTaskSmallInformationsInProject(projectIdOnView, [
        taskSmallInformation,
      ]),
      _storageAPI.updateTaskSmallInformationsInProject(
        projectIdOnView,
        [newTaskInformation],
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
  Future<void> addNewAssigneeToProject(String assigneeEmail) async {
    final assignee =
        await _storageAPI.userStreamByEmailInUser(assigneeEmail).first;
    final project = await _storageAPI.projectStream(projectIdOnView).first;

    final invitation = ProjectInvitationModel(
      id: const UuidV8().generate(),
      projectId: projectIdOnView,
      projectName: projectOnViewName,
      projectLeaderId: project.leader,
      projectLeaderImageUrl: project.leaderImageUrl,
      senderEmail: userEmailAddress,
      senderId: userId,
      senderImageUrl: userImageUrl,
      senderUsername: username,
      receiverId: assignee.id,
    );

    await Future.wait<void>(
      [
        _storageAPI.updateAssigneesInProject(projectIdOnView, [assignee.id]),
        _storageAPI.updateAssigneeImageUrlsInProject(
          projectIdOnView,
          [assignee.imageUrl],
        ),
        _storageAPI.updateProjectInvitationsInUser(
          assignee.id,
          [invitation.id],
        ),
        _storageAPI.createNewProjectInvitation(invitation),
      ],
    );
  }

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
    final fileModels = files
        .map(
          (e) => FileModel(
            ownerId: userId,
            fileName: e.path.split('/').last,
            uploadDate: DateTime.now(),
            ownerImageUrl: userImageUrl,
            ownerName: username,
          ),
        )
        .toList();

    newSubTask = newSubTask.copyWith(
      files: fileModels,
    );

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

    final taskSmallInformations = await _storageAPI
        .projectStream(projectIdOnView)
        .first
        .then((value) => value.taskSmallInformations);

    final taskSmallInformation = taskSmallInformations.firstWhere(
      (element) => element.id == taskIdOnView,
    );

    final newTaskInformation = taskSmallInformation.copyWith(
      subTaskSmallInformations: [
        ...taskSmallInformation.subTaskSmallInformations,
        subTaskSmallInformation,
      ],
    );

    // Update the task small information in project
    await Future.wait<void>([
      _storageAPI.removeTaskSmallInformationsInProject(projectIdOnView, [
        taskSmallInformation,
      ]),
      _storageAPI.updateTaskSmallInformationsInProject(
        projectIdOnView,
        [newTaskInformation],
      ),
    ]);

    final currentProject =
        await _storageAPI.projectStream(projectIdOnView).first;

    final currentFilesSmallInformation = currentProject.filesSmallInformations
        .firstWhere((element) => element.taskId == taskIdOnView);

    final newFilesSmallInformation =
        currentFilesSmallInformation.copyWith(files: fileModels);

    // Update the files small information in project
    await Future.wait<void>([
      _storageAPI.removeFilesSmallInformationsInProject(projectIdOnView, [
        currentFilesSmallInformation,
      ]),
      _storageAPI.updateFilesSmallInformationsInProject(
        projectIdOnView,
        [newFilesSmallInformation],
      ),
    ]);

    // Increase total files links in project
    await _storageAPI.updateTotalFileLinksInProject(
      projectIdOnView,
      fileModels.length,
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

  Future<void> updateFilesWithoutOverridePermissionToSubTask({
    required List<File> files,
  }) async {
    final fileModels = files
        .map(
          (e) => FileModel(
            ownerId: userId,
            fileName: e.path.split('/').last,
            uploadDate: DateTime.now(),
            ownerImageUrl: userImageUrl,
            ownerName: username,
          ),
        )
        .toList();

    final currentFileModels = await _storageAPI
        .subTaskModelStream(subTaskIdOnView)
        .first
        .then((value) => value.files);

    final needToUpdateFileModels = fileModels
        .where((element) => !currentFileModels.contains(element))
        .toList();

    final needToUpdateFiles = files
        .where((element) => needToUpdateFileModels
            .map((e) => e.fileName)
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

    final currentFilesSmallInformation = await _storageAPI
        .projectStream(projectIdOnView)
        .first
        .then((value) => value.filesSmallInformations
            .firstWhere((element) => element.taskId == taskIdOnView));

    final newFilesSmallInformation = currentFilesSmallInformation.copyWith(
      files: [
        ...currentFilesSmallInformation.files,
        ...needToUpdateFileModels,
      ],
    );

    // Update the files small information in project
    await Future.wait<void>([
      _storageAPI.removeFilesSmallInformationsInProject(projectIdOnView, [
        currentFilesSmallInformation,
      ]),
      _storageAPI.updateFilesSmallInformationsInProject(
        projectIdOnView,
        [newFilesSmallInformation],
      ),
    ]);

    // Increase total files links in project
    await _storageAPI.updateTotalFileLinksInProject(
      projectIdOnView,
      needToUpdateFileModels.length,
    );

    await Future.wait<void>(
      [
        _storageAPI.updateFilesInSubTask(
          subTaskIdOnView,
          needToUpdateFileModels,
        ),
      ],
    );
  }

  Future<void> updateFilesWithOverridePermissionToSubTask({
    required List<File> files,
  }) async {
    final fileModels = files.map(
      (e) => FileModel(
        ownerId: userId,
        fileName: e.path.split('/').last,
        uploadDate: DateTime.now(),
        ownerImageUrl: userImageUrl,
        ownerName: username,
      ),
    );

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

    // Get the current files in sub task
    final currentFileModels = await _storageAPI
        .subTaskModelStream(subTaskIdOnView)
        .first
        .then((value) => value.files);

    // Remove all the files have the same name as the new files
    final fileUrls = files.map((e) => 'files/${e.path.split('/').last}');
    final needToRemoveFileModels = currentFileModels
        .where(
          (element) => fileUrls.contains(
            element.fileName,
          ),
        )
        .toList();

    // Remove the files from storage and decrease the total file links in project
    await Future.wait<void>(
      [
        for (var file in needToRemoveFileModels)
          FirebaseFirestoreConfigs.storageRef.child(file.fileName).delete(),
        _storageAPI.updateTotalFileLinksInProject(
          projectIdOnView,
          -needToRemoveFileModels.length,
        ),
      ],
    );

    final newFileModels = [
      ...currentFileModels
          .where(
            (element) => !needToRemoveFileModels.contains(element),
          )
          .toList(),
      ...fileModels,
    ];

    // Remove and Update the files model in sub task, increase the total file links in project
    await Future.wait<void>(
      [
        _storageAPI.removeFilesInSubTask(
          subTaskIdOnView,
          needToRemoveFileModels,
        ),
        _storageAPI.updateFilesInSubTask(
          subTaskIdOnView,
          newFileModels,
        ),
        _storageAPI.updateTotalFileLinksInProject(
          projectIdOnView,
          newFileModels.length,
        ),
      ],
    );

    final currentFilesSmallInformation =
        await _storageAPI.projectStream(projectIdOnView).first.then(
              (value) => value.filesSmallInformations.firstWhere(
                (element) => element.taskId == taskIdOnView,
              ),
            );


    final newFilesSmallInformations = currentFilesSmallInformation.copyWith(
      files: [
        ...currentFilesSmallInformation.files
            .where((element) => !needToRemoveFileModels.contains(element)),
        ...fileModels,
      ],
    );

    // Update the files small information in project
    await Future.wait<void>([
      _storageAPI.removeFilesSmallInformationsInProject(projectIdOnView, [
        currentFilesSmallInformation,
      ]),
      _storageAPI.updateFilesSmallInformationsInProject(
        projectIdOnView,
        [newFilesSmallInformations],
      ),
    ]);
  }

  Future<void> removeFilesFromSubTask({
    required List<String> fileUrls,
  }) async {
    // Remove file from storage and decrease the total file links in project
    await Future.wait<void>(
      [
        for (var fileUrl in fileUrls)
          FirebaseFirestoreConfigs.storageRef.child(fileUrl).delete(),
        _storageAPI.updateTotalFileLinksInProject(
          projectIdOnView,
          -fileUrls.length,
        )
      ],
    );

    // Remove the files from sub task
    final removedFileModels =
        await _storageAPI.subTaskModelStream(subTaskIdOnView).first.then(
              (value) => value.files
                  .where(
                    (element) => fileUrls
                        .map((e) => e.split('/').last)
                        .contains(element.fileName),
                  )
                  .toList(),
            );

    await Future.wait<void>(
      [
        _storageAPI.removeFilesInSubTask(
          subTaskIdOnView,
          removedFileModels,
        ),
      ],
    );

    // Update the files small information in project
    final currentFilesSmallInformation =
        await _storageAPI.projectStream(projectIdOnView).first.then(
              (value) => value.filesSmallInformations.firstWhere(
                (element) => element.taskId == taskIdOnView,
              ),
            );

    final newFilesSmallInformation = currentFilesSmallInformation.copyWith(
      files: [
        ...currentFilesSmallInformation.files
            .where((element) => !removedFileModels.contains(element)),
      ],
    );

    await Future.wait<void>([
      _storageAPI.removeFilesSmallInformationsInProject(projectIdOnView, [
        currentFilesSmallInformation,
      ]),
      _storageAPI.updateFilesSmallInformationsInProject(
        projectIdOnView,
        [newFilesSmallInformation],
      ),
    ]);
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
    // update task in user
    await Future.wait<void>(
      [
        _storageAPI.updateTasksInUser(userId, [newTask.id]),
      ],
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
        _storageAPI.updateFilesSmallInformationsInProject(
          projectIdOnView,
          [
            FilesSmallInformation(
              taskId: newTask.id,
              taskName: newTask.name,
              files: const [],
            ),
          ],
        ),
        _storageAPI.updateTaskSmallInformationsInProject(
          projectIdOnView,
          [
            TaskSmallInformation(
              id: newTask.id,
              name: newTask.name,
              subTaskSmallInformations: const [],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> updateTaskName({
    required String taskId,
    required String taskName,
  }) async {
    await Future.wait<void>(
      [
        _storageAPI.updateNameInTask(
          taskId,
          taskName,
        ),
      ],
    );

    // Update task name in FilesInformation in project
    final currentProject =
        await _storageAPI.projectStream(projectIdOnView).first;

    final currentFilesSmallInformation = currentProject.filesSmallInformations
        .firstWhere((element) => element.taskId == taskId);

    final newFilesSmallInformation = currentFilesSmallInformation.copyWith(
      taskName: taskName,
    );

    // Update the files small information in project
    await Future.wait<void>([
      _storageAPI.removeFilesSmallInformationsInProject(projectIdOnView, [
        currentFilesSmallInformation,
      ]),
      _storageAPI.updateFilesSmallInformationsInProject(
        projectIdOnView,
        [newFilesSmallInformation],
      ),
    ]);
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
    if (oldPoints != points) {
      final taskSmallInformations = await _storageAPI
          .projectStream(projectIdOnView)
          .first
          .then((value) => value.taskSmallInformations);

      final taskSmallInformation = taskSmallInformations.firstWhere(
        (element) => element.id == taskIdOnView,
      );

      final subTaskSmallInformation = taskSmallInformation
          .subTaskSmallInformations
          .firstWhere((element) => element.id == subTaskIdOnView);

      final newSubTaskSmallInformation = subTaskSmallInformation.copyWith(
        points: points,
      );

      final newTaskSmallInformation = taskSmallInformation.copyWith(
        subTaskSmallInformations: [
          ...taskSmallInformation.subTaskSmallInformations
              .where((element) => element.id != subTaskIdOnView),
          newSubTaskSmallInformation,
        ],
      );

      await Future.wait<void>([
        _storageAPI.updatePointsInSubTask(subTaskIdOnView, points),
        _storageAPI.updatePointsInTask(taskIdOnView, points - oldPoints),
        _storageAPI.removeTaskSmallInformationsInProject(projectIdOnView, [
          taskSmallInformation,
        ]),
        _storageAPI.updateTaskSmallInformationsInProject(
          projectIdOnView,
          [newTaskSmallInformation],
        ),
      ]);
    }
    final subTaskCompleted = await _storageAPI
        .subTaskModelStream(subTaskIdOnView)
        .first
        .then((value) => value.isCompleted);

    await Future.wait<void>(
      [
        _storageAPI.updateDescriptionInSubTask(subTaskIdOnView, description),
        _storageAPI.updateDueDateInSubTask(subTaskIdOnView, dueDate),
        _storageAPI.updateGradeInSubTask(subTaskIdOnView, grade),
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

  Future<void> deleteSubTask({
    required String subTaskId,
    required String taskId,
  }) async {
    // Remove all the files in storage
    // then remove all comments in sub task and in comments collection
    // and reduce the total file links in project
    // remove sub task in assignee
    final subTask = await _storageAPI.subTaskModelStream(subTaskId).first;

    await Future.wait<void>(
      [
        for (var file in subTask.files)
          FirebaseFirestoreConfigs.storageRef
              .child('files/${file.fileName}')
              .delete(),
        _storageAPI.removeCommentsInSubTask(subTaskId, subTask.comments),
        for (var commentId in subTask.comments)
          _storageAPI.deleteComment(commentId),
        _storageAPI.updateTotalFileLinksInProject(
          projectIdOnView,
          -subTask.files.length,
        ),
        _storageAPI.removeSubTasksInUser(subTask.assignee, [subTaskId]),
      ],
    );

    // Remove subtask id in task
    // decrease points of task
    await Future.wait<void>(
      [
        _storageAPI.removeSubTasksInTask(taskId, [subTaskId]),
        _storageAPI.updatePointsInTask(taskId, -subTask.points),
      ],
    );

    // check if this sub task is completed,
    // then decrease sub task completed in task
    // and decrease activities completed in project
    // then decrease total activities in project
    await Future.wait<void>(
      [
        if (subTask.isCompleted) ...[
          _storageAPI.updateSubTasksCompletedInTask(taskId, -1),
          _storageAPI.updateActivitiesCompletedInProject(projectIdOnView, -1),
        ],
        _storageAPI.updateTotalActivitiesInProject(projectIdOnView, -1),
      ],
    );

    // Check if the task is empty and mark completed
    // then mark task incomplete and decrease tasks completed in project
    final task = await _storageAPI.taskStream(taskId).first;
    if (task.subTasks.isEmpty && task.isCompleted) {
      await Future.wait<void>([
        _storageAPI.updateIsCompletedInTask(taskId, false),
        _storageAPI.updateTasksCompletedInProject(projectIdOnView, -1),
      ]);
    }

    // update task small information in project
    final taskSmallInformations = await _storageAPI
        .projectStream(projectIdOnView)
        .first
        .then((value) => value.taskSmallInformations);

    final taskSmallInformation = taskSmallInformations.firstWhere(
      (element) => element.id == taskId,
    );

    final newTaskSmallInformation = taskSmallInformation.copyWith(
      subTaskSmallInformations: [
        ...taskSmallInformation.subTaskSmallInformations
            .where((element) => element.id != subTaskId),
      ],
    );

    await Future.wait<void>([
      _storageAPI.removeTaskSmallInformationsInProject(projectIdOnView, [
        taskSmallInformation,
      ]),
      _storageAPI.updateTaskSmallInformationsInProject(
        projectIdOnView,
        [newTaskSmallInformation],
      ),
    ]);

    // Update file small information in project
    final fileSmallInformation = await _storageAPI
        .projectStream(projectIdOnView)
        .first
        .then((value) => value.filesSmallInformations
            .firstWhere((element) => element.taskId == taskId));

    final newFileSmallInformation = fileSmallInformation.copyWith(
      files: [
        ...fileSmallInformation.files
            .where((element) => !subTask.files.contains(element)),
      ],
    );

    await Future.wait<void>([
      _storageAPI.removeFilesSmallInformationsInProject(projectIdOnView, [
        fileSmallInformation,
      ]),
      _storageAPI.updateFilesSmallInformationsInProject(
        projectIdOnView,
        [newFileSmallInformation],
      ),
    ]);

    // Remove sub task
    await _storageAPI.deleteSubTask(subTaskId);
  }

  Future<void> deleteTask({
    required String taskId,
  }) async {
    // delete all sub tasks in task
    final task = await _storageAPI.taskStream(taskId).first;

    await Future.wait<void>(
      [
        for (var subTaskId in task.subTasks)
          deleteSubTask(
            subTaskId: subTaskId,
            taskId: taskId,
          ),
      ],
    );

    // Update task small information in project
    final taskSmallInformations = await _storageAPI
        .projectStream(projectIdOnView)
        .first
        .then((value) => value.taskSmallInformations);

    final taskSmallInformation = taskSmallInformations.firstWhere(
      (element) => element.id == taskId,
    );

    await Future.wait<void>([
      _storageAPI.removeTaskSmallInformationsInProject(projectIdOnView, [
        taskSmallInformation,
      ]),
    ]);

    // Delete task in project
    await _storageAPI.removeTasksInProject(projectIdOnView, [taskId]);

    // Update file small information in project
    final fileSmallInformation = await _storageAPI
        .projectStream(projectIdOnView)
        .first
        .then((value) => value.filesSmallInformations
            .firstWhere((element) => element.taskId == taskId));

    await Future.wait<void>([
      _storageAPI.removeFilesSmallInformationsInProject(projectIdOnView, [
        fileSmallInformation,
      ]),
    ]);

    // Delete task
    await _storageAPI.deleteTask(taskId);
  }

  Future<void> deleteProject({
    required String projectId,
  }) async {
    // Delete all tasks in project
    final project = await _storageAPI.projectStream(projectId).first;

    await Future.wait<void>(
      [
        for (var taskId in project.tasks)
          deleteTask(
            taskId: taskId,
          ),
      ],
    );

    // Delete project in user, decrease ongoing projects in user
    // and decrease leader projects in user if the user is leader
    await Future.wait<void>(
      [
        _storageAPI.removeProjectsInUser(userId, [projectId]),
        _storageAPI.updateOnGoingProjectsInUser(userId, -1),
        if (project.leader == userId)
          _storageAPI.updateLeaderProjectsInUser(userId, -1),
        if (project.isCompleted)
          _storageAPI.updateCompletedProjectsInUser(userId, -1),
      ],
    );

    // delete all invitations in project
    final List<ProjectInvitationModel> invitations =
        await FirebaseFirestoreConfigs.projectInvitationsCollection
            .where(
              "projectId",
              isEqualTo: projectId,
            )
            .get()
            .then((value) => value.docs
                .map(
                  (e) => ProjectInvitationModel.fromJson(
                    e.data() as Map<String, dynamic>,
                  ),
                )
                .toList())
            .onError((error, stackTrace) => []);

    // Remove all invitations in user
    await Future.wait<void>(
      [
        for (var invitation in invitations)
          _storageAPI.removeProjectInvitationsInUser(
            invitation.receiverId,
            [invitation.id],
          ),
      ],
    );

    // Delete project
    await _storageAPI.deleteProject(projectId);
  }
  // Task / View files

  // Thread / View thread
  Future<void> addNewMessage({
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
        _storageAPI.updateMessagesInThread(threadIdOnView, [newMessage.id]),
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
        _storageAPI.updateMessagesInThread(threadIdOnView, [newMessage.id]),
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
        _storageAPI.updateMessagesInThread(threadIdOnView, [newMessage.id]),
        _storageAPI.updateFileToStorage(file: file),
      ]);
    }
  }

  Future<File> downloadFile(String fileUrl) async => await _storageAPI
      .downloadFile(fileUrl)
      .onError((error, stackTrace) => File(""));

  // Home
  Future<Task> projectIdOfSubTask(String subTaskId) async =>
      await _storageAPI.projectIdInTaskBySubTaskId(subTaskId);

  Future<Map<String, List<Stream<SubTaskModel>>>> subTasksForEachProject(
      List<String> subTaskIds) async {
    final subTasksMap = <String, List<Stream<SubTaskModel>>>{};
    await Future.wait<void>(
      [
        for (var subTask in subTaskIds)
          projectIdOfSubTask(subTask)
              .then(
            (value) => subTasksMap[value.project] = [
              ...subTasksMap[value.project] ?? [],
              _storageAPI.subTaskModelStream(subTask),
            ],
          )
              .onError((error, stackTrace) {
            debugPrint(subTask);
            return [];
          })
      ],
    );

    return subTasksMap;
  }

  Future<int> tagsCountOfProject(String projectId) async => await _storageAPI
          .projectStream(projectId)
          .first
          .then(
            (value) => value.tags.length,
          )
          .onError((error, stackTrace) {
        return 0;
      });

  Future<String> projectNameOfProject(String projectId) async =>
      await _storageAPI
          .projectStream(projectId)
          .first
          .then(
            (value) => value.name,
          )
          .onError((error, stackTrace) => "");
}
