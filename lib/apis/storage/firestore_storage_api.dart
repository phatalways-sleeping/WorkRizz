part of 'storage_api.dart';

final class CloudFirestoreStorageAPI extends StorageAPI {
  const CloudFirestoreStorageAPI();

  // CREATE
  @override
  Future<void> createNewUser(UserDataModel userDataModel) =>
      CreateUser.createUser(userDataModel);
  @override
  Future<void> createNewUserActivity(UserActivityModel userActivityModel) =>
      CreateUserActivity.createUserActivity(userActivityModel);
  @override
  Future<void> createNewProject(Project project) =>
      CreateProject.createNewProject(project);
  @override
  Future<void> createNewTask(Task task) => CreateTask.createTask(task);
  @override
  Future<void> createNewSubTask(SubTaskModel subTaskModel) =>
      CreateSubTask.createSubTask(subTaskModel);
  @override
  Future<void> createNewPersonalSchedule(
    PersonalScheduleModel personalScheduleModel,
  ) =>
      CreatePersonalSchedule.createNewPersonalSchedule(personalScheduleModel);
  @override
  Future<void> createNewThread(ThreadModel threadModel) =>
      CreateThread.createNewThread(threadModel);
  @override
  Future<void> createNewMessage(MessageModel messageModel) =>
      CreateMessage.createNewMessage(messageModel);

  // READ
  // - UserDataModel
  @override
  Stream<UserDataModel> userStreamByEmailInUser(String email) =>
      ReadUser.userStreamByEmail(email);
  @override
  Stream<UserDataModel> userStreamByIdInUser(String id) =>
      ReadUser.userStreamById(id);
  @override
  Stream<String> usernameOfUserByEmailInUser(String email) =>
      ReadUser.usernameOfUserByEmail(email);
  @override
  Stream<String> usernameOfUserByIdInUser(String id) =>
      ReadUser.usernameOfUserById(id);
  @override
  Stream<String> imageUrlStreamOfUserByEmailInUser(String email) =>
      ReadUser.imageUrlStreamOfUserByEmail(email);
  @override
  Stream<String> imageUrlStreamOfUserByIdInUser(String id) =>
      ReadUser.imageUrlStreamOfUserById(id);
  @override
  Future<String> emailOfUserInUser(String id) => ReadUser.emailOfUser(id);
  // - UserActivityModel
  @override
  Stream<UserActivityModel> userActivityStreamInUserActivity(String id) =>
      ReadUserActivity.userActivityStream(id);
  @override
  Stream<bool> onlineStatusOfUserStreamInUserActivity(String id) =>
      ReadUserActivity.onlineStatusOfUserStream(id);
  @override
  Stream<DateTime> lastActiveOfUserStreamInUserActivity(String id) =>
      ReadUserActivity.lastActiveOfUserStream(id);
  // - PersonalScheduleModel
  @override
  Stream<PersonalScheduleModel> personalScheduleStreamInPersonalSchedule(
          String id) =>
      ReadPersonalSchedule.personalScheduleStreamById(id);
  @override
  Future<DateTime> dateScheduleInPersonalSchedule(String id) =>
      ReadPersonalSchedule.dateSchedule(id);
  // - Project
  @override
  Stream<Project> projectStream(String id) => ReadProject.projectStream(id);
  // - Task
  @override
  Future<String> taskNameInTask(String id) => ReadTask.taskName(id);
  @override
  Future<String> projectIdInTask(String id) => ReadTask.projectIdBelongTo(id);
  @override
  Stream<Task> taskStream(String id) => ReadTask.taskStreamById(id);
  // - SubTask
  @override
  Future<String> assigneeOfSubTask(String id) =>
      ReadSubTask.assigneeOfSubTask(id);
  @override
  Future<String> nameOfSubTask(String id) => ReadSubTask.nameOfSubTask(id);
  @override
  Stream<SubTaskModel> subTaskModelStream(String id) =>
      ReadSubTask.subTaskModelStreamById(id);
  // - ThreadModel
  @override
  Stream<ThreadModel> threadStream(String id) =>
      ReadThread.threadStreamById(id);
  // - MessageModel
  @override
  Stream<MessageModel> messageStream(String id) =>
      ReadMessage.messageStreamById(id);

  // UPDATE
  // - UserDataModel
  @override
  Future<void> updateImageUrlInUser(String id, String imageUrl) =>
      UpdateUser.updateImageUrl(id, imageUrl);
  @override
  Future<void> updateUsernameInUser(String id, String username) =>
      UpdateUser.updateUsername(id, username);
  @override
  Future<void> updateEmailInUser(String id, String email) =>
      UpdateUser.updateEmail(id, email);
  @override
  Future<void> updateLeaderProjectsInUser(String id, int leaderProjects) =>
      UpdateUser.updateLeaderProjects(id, leaderProjects);
  @override
  Future<void> updateOnGoingProjectsInUser(String id, int onGoingProjects) =>
      UpdateUser.updateOnGoingProjects(id, onGoingProjects);
  @override
  Future<void> updateCompletedProjectsInUser(
          String id, int completedProjects) =>
      UpdateUser.updateCompletedProjects(id, completedProjects);
  @override
  Future<void> updateProjectsInUser(String id, List<String> latestVersion) =>
      UpdateUser.updateProjects(id, latestVersion);
  @override
  Future<void> updateTasksInUser(String id, List<String> latestVersion) =>
      UpdateUser.updateTasks(id, latestVersion);
  @override
  Future<void> updateSubTasksInUser(String id, List<String> latestVersion) =>
      UpdateUser.updateSubTasks(id, latestVersion);
  @override
  Future<void> updatePersonalScheduleInUser(
          String id, List<String> latestVersion) =>
      UpdateUser.updatePersonalSchedule(id, latestVersion);
  @override
  Future<void> removeProjectsInUser(String id, List<String> removedItems) =>
      UpdateUser.removeProjects(id, removedItems);
  @override
  Future<void> removeTasksInUser(String id, List<String> removedItems) =>
      UpdateUser.removeTasks(id, removedItems);
  @override
  Future<void> removeSubTasksInUser(String id, List<String> removedItems) =>
      UpdateUser.removeSubTasks(id, removedItems);
  @override
  Future<void> removePersonalScheduleInUser(
          String id, List<String> removedItems) =>
      UpdateUser.removePersonalSchedule(id, removedItems);
  // - UserActivityModel
  @override
  Future<void> updateUserActivity(
    String id,
    bool isActive,
    DateTime lastActive,
  ) =>
      UpdateUserActivity.updateUserActivity(id, isActive, lastActive);
  // - PersonalScheduleModel
  @override
  Future<void> updateStatusInSchedule(String id, TimelineStatus status) =>
      UpdatePersonalSchedule.updateStatus(id, status);
  @override
  Future<void> updateTimelineInSchedule(
          String id, TimelineModel timelineModel) =>
      UpdatePersonalSchedule.updateTimeline(id, timelineModel);
  // - Project
  @override
  Future<void> updateAssigneesInProject(
          String id, List<String> latestVersion) =>
      UpdateProject.updateAssignees(id, latestVersion);
  @override
  Future<void> removeAssigneesInProject(String id, List<String> removedItems) =>
      UpdateProject.removeAssignees(id, removedItems);
  @override
  Future<void> updateTasksCompletedInProject(String id, int tasksCompleted) =>
      UpdateProject.updateTasksCompleted(id, tasksCompleted);
  @override
  Future<void> updateActivitiesCompletedInProject(
          String id, int activitiesCompleted) =>
      UpdateProject.updateActivitiesCompleted(id, activitiesCompleted);
  @override
  Future<void> updateTotalActivitiesInProject(String id, int totalActivities) =>
      UpdateProject.updateTotalActivities(id, totalActivities);
  @override
  Future<void> updateIsCompletedInProject(String id, bool isCompleted) =>
      UpdateProject.updateIsCompleted(id, isCompleted);
  @override
  Future<void> updateStartDateInProject(String id, DateTime startDate) =>
      UpdateProject.updateStartDate(id, startDate);
  @override
  Future<void> updateEndDateInProject(String id, DateTime endDate) =>
      UpdateProject.updateEndDate(id, endDate);
  @override
  Future<void> updateLeaderInProject(String id, String leader) =>
      UpdateProject.updateLeader(id, leader);
  @override
  Future<void> updateMostActiveMembersInProject(
          String id, List<String> latestVersion) =>
      UpdateProject.updateMostActiveMembers(id, latestVersion);
  @override
  Future<void> removeMostActiveMembersInProject(
          String id, List<String> removedItems) =>
      UpdateProject.removeMostActiveMembers(id, removedItems);
  @override
  Future<void> updateNameInProject(String id, String name) =>
      UpdateProject.updateName(id, name);
  @override
  Future<void> updateTagsInProject(String id, List<Tag> latestVersion) =>
      UpdateProject.updateTags(id, latestVersion);
  @override
  Future<void> removeTagsInProject(String id, List<Tag> removedItems) =>
      UpdateProject.removeTags(id, removedItems);
  @override
  Future<void> updateTasksInProject(String id, List<String> latestVersion) =>
      UpdateProject.updateTasks(id, latestVersion);
  @override
  Future<void> removeTasksInProject(String id, List<String> removedItems) =>
      UpdateProject.removeTasks(id, removedItems);
  @override
  Future<void> updateThreadInProject(String id, String thread) =>
      UpdateProject.updateThread(id, thread);
  // - Task
  @override
  Future<void> updateNameInTask(String id, String name) =>
      UpdateTask.updateName(id, name);
  @override
  Future<void> updateIsCompletedInTask(String id, bool isCompleted) =>
      UpdateTask.updateIsCompleted(id, isCompleted);
  @override
  Future<void> updatePointsInTask(String id, int points) =>
      UpdateTask.updatePoints(id, points);
  @override
  Future<void> updateSubTasksInTask(String id, List<String> latestVersion) =>
      UpdateTask.updateSubTasks(id, latestVersion);
  @override
  Future<void> removeSubTasksInTask(String id, List<String> removedItems) =>
      UpdateTask.removeSubTasks(id, removedItems);
  @override
  Future<void> updateTaskInTask(String id, Task task) =>
      UpdateTask.updateTask(id, task);
  // - SubTask
  @override
  Future<void> updateAssigneeInSubTask(String id, String assignee) =>
      UpdateSubTask.updateAssignee(id, assignee);
  @override
  Future<void> updateDescriptionInSubTask(String id, String description) =>
      UpdateSubTask.updateDescription(id, description);
  @override
  Future<void> updateGradeInSubTask(String id, int grade) =>
      UpdateSubTask.updateGrade(id, grade);
  @override
  Future<void> updateIsCompletedInSubTask(String id, bool isCompleted) =>
      UpdateSubTask.updateIsCompleted(id, isCompleted);
  @override
  Future<void> updateLeaderCommentInSubTask(String id, String leaderComment) =>
      UpdateSubTask.updateLeaderComment(id, leaderComment);
  @override
  Future<void> updateNameInSubTask(String id, String name) =>
      UpdateSubTask.updateName(id, name);
  @override
  Future<void> updatePointsInSubTask(String id, int points) =>
      UpdateSubTask.updatePoints(id, points);
  @override
  Future<void> updateProgressInSubTask(String id, double progress) =>
      UpdateSubTask.updateProgress(id, progress);
  @override
  Future<void> updateDueDateInSubTask(String id, DateTime dueDate) =>
      UpdateSubTask.updateDueDate(id, dueDate);
  @override
  Future<void> updateCommentsInSubTask(String id, List<String> latestVersion) =>
      UpdateSubTask.updateComments(id, latestVersion);
  @override
  Future<void> removeCommentsInSubTask(String id, List<String> removedItems) =>
      UpdateSubTask.removeComments(id, removedItems);
  @override
  Future<void> updateFilesInSubTask(String id, List<String> latestVersion) =>
      UpdateSubTask.updateFiles(id, latestVersion);
  @override
  Future<void> removeFilesInSubTask(String id, List<String> removedItems) =>
      UpdateSubTask.removeFiles(id, removedItems);
  @override
  Future<void> updateSubTaskInSubTask(String id, SubTaskModel subTaskModel) =>
      UpdateSubTask.updateSubTask(id, subTaskModel);
  // - ThreadModel
  @override
  Future<void> updateMessagesInThread(String id, List<String> latestVersion) =>
      UpdateThread.updateMessages(id, latestVersion);
  @override
  Future<void> removeMessagesInThread(String id, List<String> removedItems) =>
      UpdateThread.removeMessages(id, removedItems);
  // - MessageModel

  // DELETE
  // - UserDataModel
  @override
  Future<void> deleteUser(String id) => DeleteUser.deleteUser(id);
  // - UserActivityModel
  @override
  Future<void> deleteUserActivity(String id) =>
      DeleteUserActivity.deleteUserActivity(id);
  // - PersonalScheduleModel
  @override
  Future<void> deletePersonalSchedule(String id) =>
      DeletePersonalSchedule.deletePersonalSchedule(id);
  // - Project
  @override
  Future<void> deleteProject(String id) => DeleteProject.deleteProject(id);
  // - Task
  @override
  Future<void> deleteTask(String id) => DeleteTask.deleteTask(id);
  // - SubTask
  @override
  Future<void> deleteSubTask(String id) => DeleteSubTask.deleteSubTask(id);
  // - ThreadModel
  @override
  Future<void> deleteThread(String id) => DeleteThread.deleteThread(id);
  // - MessageModel
  @override
  Future<void> deleteMessage(String id) => DeleteMessage.deleteMessage(id);
}
