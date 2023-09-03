import 'dart:async';

import 'package:task_managing_application/apis/storage/crud.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/models/personal_schedule/personal_schedule_model.dart';
import 'package:task_managing_application/models/personal_schedule/time_line/time_line_model.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';

part 'firestore_storage_api.dart';
part 'shared_preference_storage_api.dart';

sealed class StorageAPI {
  const StorageAPI();
  // CREATE
  Future<void> createNewUser(UserDataModel userDataModel);
  Future<void> createNewUserActivity(UserActivityModel userActivityModel);
  Future<void> createNewProject(Project project);
  Future<void> createNewTask(Task task);
  Future<void> createNewSubTask(SubTaskModel subTaskModel);
  Future<void> createNewPersonalSchedule(
    PersonalScheduleModel personalScheduleModel,
  );
  Future<void> createNewThread(ThreadModel threadModel);
  Future<void> createNewMessage(MessageModel messageModel);
  Future<void> createNewComment(CommentModel commentModel);

  // READ
  // - UserDataModel
  Stream<UserDataModel> userStreamByEmailInUser(String email);
  Stream<UserDataModel> userStreamByIdInUser(String id);
  Stream<String> usernameOfUserByEmailInUser(String email);
  Stream<String> usernameOfUserByIdInUser(String id);
  Stream<String> imageUrlStreamOfUserByEmailInUser(String email);
  Stream<String> imageUrlStreamOfUserByIdInUser(String id);
  Future<String> emailOfUserInUser(String id);
  // - UserActivityModel
  Stream<UserActivityModel> userActivityStreamInUserActivity(String id);
  Stream<bool> onlineStatusOfUserStreamInUserActivity(String id);
  Stream<DateTime> lastActiveOfUserStreamInUserActivity(String id);
  // - PersonalScheduleModel
  Stream<PersonalScheduleModel> personalScheduleStreamInPersonalSchedule(
      String id);
  Future<DateTime> dateScheduleInPersonalSchedule(String id);
  // - Project
  Stream<Project> projectStream(String id);
  // - Task
  Future<String> taskNameInTask(String id);
  Future<String> projectIdInTask(String id);
  Stream<Task> taskStream(String id);
  // - SubTask
  Future<String> assigneeOfSubTask(String id);
  Future<String> nameOfSubTask(String id);
  Stream<SubTaskModel> subTaskModelStream(String id);
  // - ThreadModel
  Stream<ThreadModel> threadStream(String id);
  // - MessageModel
  Stream<MessageModel> messageStream(String id);
  // - CommentModel
  Future<CommentModel> commentFuture(String id);

  // UPDATE
  // - UserDataModel
  Future<void> updateImageUrlInUser(String id, String imageUrl);
  Future<void> updateUsernameInUser(String id, String username);
  Future<void> updateEmailInUser(String id, String email);
  Future<void> updateLeaderProjectsInUser(String id, int leaderProjects);
  Future<void> updateOnGoingProjectsInUser(String id, int onGoingProjects);
  Future<void> updateCompletedProjectsInUser(String id, int completedProjects);
  Future<void> updateProjectsInUser(String id, List<String> latestVersion);
  Future<void> updateTasksInUser(String id, List<String> latestVersion);
  Future<void> updateSubTasksInUser(String id, List<String> latestVersion);
  Future<void> updatePersonalScheduleInUser(
    String id,
    List<String> latestVersion,
  );
  Future<void> updateProjectInvitationsInUser(
    String id,
    List<String> latestVersion,
  );
  Future<void> removeProjectsInUser(String id, List<String> removedItems);
  Future<void> removeTasksInUser(String id, List<String> removedItems);
  Future<void> removeSubTasksInUser(String id, List<String> removedItems);
  Future<void> removePersonalScheduleInUser(
    String id,
    List<String> removedItems,
  );
  Future<void> removeProjectInvitationsInUser(
    String id,
    List<String> removedItems,
  );
  // - UserActivityModel
  Future<void> updateUserActivity(
    String id,
    bool isActive,
    DateTime lastActive,
  );
  // - PersonalScheduleModel
  Future<void> updateStatusInSchedule(String id, TimelineStatus status);
  Future<void> updateTimelineInSchedule(String id, TimelineModel timelineModel);
  // - Project
  Future<void> updateAssigneesInProject(String id, List<String> latestVersion);
  Future<void> removeAssigneesInProject(String id, List<String> removedItems);
  Future<void> updateAssigneeImageUrlsInProject(String id, List<String> latestVersion);
  Future<void> removeAssigneeImageUrlsInProject(String id, List<String> removedItems);
  Future<void> updateTasksCompletedInProject(String id, int tasksCompleted);
  Future<void> updateActivitiesCompletedInProject(
      String id, int activitiesCompleted);
  Future<void> updateTotalActivitiesInProject(String id, int totalActivities);
  Future<void> updateTotalFileLinksInProject(String id, int totalFileLinks);
  Future<void> updateIsCompletedInProject(String id, bool isCompleted);
  Future<void> updateStartDateInProject(String id, DateTime startDate);
  Future<void> updateEndDateInProject(String id, DateTime endDate);
  Future<void> updateLeaderInProject(String id, String leader);
  Future<void> updateLeaderImageUrlInProject(String id, String leaderImageUrl);
  Future<void> updateMostActiveMembersInProject(
      String id, List<String> latestVersion);
  Future<void> removeMostActiveMembersInProject(
      String id, List<String> removedItems);
  Future<void> updateNameInProject(String id, String name);
  Future<void> updateTagsInProject(String id, List<Tag> latestVersion);
  Future<void> removeTagsInProject(String id, List<Tag> removedItems);
  Future<void> updateTasksInProject(String id, List<String> latestVersion);
  Future<void> removeTasksInProject(String id, List<String> removedItems);
  Future<void> updateThreadInProject(String id, String thread);
  // - Task
  Future<void> updateNameInTask(String id, String name);
  Future<void> updateIsCompletedInTask(String id, bool isCompleted);
  Future<void> updatePointsInTask(String id, int points);
  Future<void> updateSubTasksInTask(String id, List<String> latestVersion);
  Future<void> removeSubTasksInTask(String id, List<String> removedItems);
  Future<void> updateTaskInTask(String id, Task task);
  // - SubTask
  Future<void> updateAssigneeInSubTask(String id, String assignee);
  Future<void> updateDescriptionInSubTask(String id, String description);
  Future<void> updateGradeInSubTask(String id, int grade);
  Future<void> updateIsCompletedInSubTask(String id, bool isCompleted);
  Future<void> updateLeaderCommentInSubTask(String id, String leaderComment);
  Future<void> updateNameInSubTask(String id, String name);
  Future<void> updatePointsInSubTask(String id, int points);
  Future<void> updateProgressInSubTask(String id, double progress);
  Future<void> updateDueDateInSubTask(String id, DateTime dueDate);
  Future<void> updateCommentsInSubTask(String id, List<String> latestVersion);
  Future<void> removeCommentsInSubTask(String id, List<String> removedItems);
  Future<void> updateFilesInSubTask(String id, List<String> latestVersion);
  Future<void> removeFilesInSubTask(String id, List<String> removedItems);
  Future<void> updateSubTaskInSubTask(String id, SubTaskModel subTaskModel);
  // - ThreadModel
  Future<void> updateMessagesInThread(String id, List<String> latestVersion);
  Future<void> removeMessagesInThread(String id, List<String> removedItems);
  // - MessageModel

  // - CommentModel
  Future<void> updateSolvedInComment(String id, bool solved);
  Future<void> updateIsRepliedInComment(String id, bool isReplied);
  Future<void> updateReplyCommentIdInComment(String id, String replyCommentId);
  // DELETE
  // - UserDataModel
  Future<void> deleteUser(String id);
  // - UserActivityModel
  Future<void> deleteUserActivity(String id);
  // - PersonalScheduleModel
  Future<void> deletePersonalSchedule(String id);
  // - Project
  Future<void> deleteProject(String id);
  // - Task
  Future<void> deleteTask(String id);
  // - SubTask
  Future<void> deleteSubTask(String id);
  // - ThreadModel
  Future<void> deleteThread(String id);
  // - MessageModel
  Future<void> deleteMessage(String id);
  // - CommentModel
  Future<void> deleteComment(String id);
}
