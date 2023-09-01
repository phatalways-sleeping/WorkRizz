part of 'storage_api.dart';

final class CloudFirestoreStorageAPI extends StorageAPI {
  const CloudFirestoreStorageAPI();

  @override
  Future<String> assigneeOfSubTask(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> createNewMessage(MessageModel messageModel) {
    throw UnimplementedError();
  }

  @override
  Future<void> createNewPersonalSchedule(
      PersonalScheduleModel personalScheduleModel) {
    throw UnimplementedError();
  }

  @override
  Future<void> createNewProject(Project project) {
    throw UnimplementedError();
  }

  @override
  Future<void> createNewSubTask(SubTaskModel subTaskModel) {
    throw UnimplementedError();
  }

  @override
  Future<void> createNewTask(Task task) {
    throw UnimplementedError();
  }

  @override
  Future<void> createNewThread(ThreadModel threadModel) {
    throw UnimplementedError();
  }

  @override
  Future<void> createNewUser(UserDataModel userDataModel) {
    throw UnimplementedError();
  }

  @override
  Future<void> createNewUserActivity(UserActivityModel userActivityModel) {
    throw UnimplementedError();
  }

  @override
  Future<DateTime> dateSchedule(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMessage(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deletePersonalSchedule(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProject(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSubTask(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteThread(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUserActivity(String id) {
    throw UnimplementedError();
  }

  @override
  Future<String> emailOfUser(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<String> imageUrlStreamOfUserByEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Stream<String> imageUrlStreamOfUserById(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<DateTime> lastActiveOfUserStream(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<MessageModel> messageStreamById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<String> nameOfSubTask(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<bool> onlineStatusOfUserStream(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<PersonalScheduleModel> personalScheduleStreamById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<String> projectIdBelongTo(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<Project> projectStream(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeAssigneesInProject(String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeCommentsInSubTask(String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeFilesInSubTask(String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeMessagesInThread(String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeMostActiveMembersInProject(
      String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removePersonalScheduleInUser(
      String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeProjectsInUser(String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeSubTasksInTask(String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeSubTasksInUser(String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeTagsInProject(String id, List<Tag> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeTasksInProject(String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeTasksInUser(String id, List<String> removedItems) {
    throw UnimplementedError();
  }

  @override
  Stream<SubTaskModel> subTaskModelStreamById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<String> taskName(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<Task> taskStreamById(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<ThreadModel> threadStreamById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateAssigneeInSubTask(String id, String assignee) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateAssigneesInProject(String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateCommentsInSubTask(String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateDescriptionInSubTask(String id, String description) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateDueDateInSubTask(String id, DateTime dueDate) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateEmailInUser(String id, String email) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateEndDateInProject(String id, DateTime endDate) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateFilesInSubTask(String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateGradeInSubTask(String id, int grade) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateImageUrlInUser(String id, String imageUrl) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateIsCompletedInSubTask(String id, bool isCompleted) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateIsCompletedInTask(String id, bool isCompleted) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateLeaderCommentInSubTask(String id, String leaderComment) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateLeaderInProject(String id, String leader) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateMessagesInThread(String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateMostActiveMembersInProject(
      String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateNameInProject(String id, String name) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateNameInSubTask(String id, String name) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateNameInTask(String id, String name) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePersonalScheduleInUser(
      String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePointsInSubTask(String id, int points) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePointsInTask(String id, int points) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProgressInSubTask(String id, double progress) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProjectsInUser(String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateStartDateInProject(String id, DateTime startDate) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateStatusInSchedule(String id, TimelineStatus status) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateSubTaskInSubTask(String id, SubTaskModel subTaskModel) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateSubTasksInTask(String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateSubTasksInUser(String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTagsInProject(String id, List<Tag> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTaskInTask(String id, Task task) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTasksInProject(String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTasksInUser(String id, List<String> latestVersion) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateThreadInProject(String id, String thread) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTimelineInSchedule(
      String id, TimelineModel timelineModel) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserActivity(
      String id, bool isActive, DateTime lastActive) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUsernameInUser(String id, String username) {
    throw UnimplementedError();
  }

  @override
  Stream<UserActivityModel> userActivityStream(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<UserDataModel> userStreamByEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Stream<UserDataModel> userStreamById(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<String> usernameOfUserByEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Stream<String> usernameOfUserById(String id) {
    throw UnimplementedError();
  }
}
