import 'package:avatar_stack/avatar_stack.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/models/task/sub_task_small_info.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/tasklist_bloc/tasklist_bloc.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_input_dialog.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';
import 'package:task_managing_application/widgets/custom_item_widget/custom_item_widget.dart';
import 'package:task_managing_application/widgets/custom_tag/project_tag.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';
import 'package:task_managing_application/widgets/tasklist/shimmer_components.dart';
import 'package:task_managing_application/widgets/tasklist/switch.dart';

part 'date.dart';
part 'mini_nav.dart';
part 'progress.dart';
part 'subtask.dart';
part 'list_tag.dart';
part 'list_subtask.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasklistBloc, TasklistState>(
      listener: (context, state) async {
        if (state is TasklistError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: context.textTheme.headlineSmall,
              ),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
        if (state is TasklistSubscriptionAndOpenTaskCreateDialog) {
          await showDialog<String>(
            context: context,
            builder: (context) => CustomInputDialog(
              title: const Text('Create new task'),
              leftText: const Text('Cancel'),
              rightText: const Text('Create'),
              inputLabel: 'Task name',
              leftColor: context.colorScheme.error,
              rightColor: context.colorScheme.primary,
              focusleftColor: context.colorScheme.error,
              focusrightColor: context.colorScheme.primary,
              onLeftPressed: (context, controller) =>
                  Navigator.of(context).pop(),
              onRightPressed: (context, controller) =>
                  Navigator.of(context).pop(controller.text.trim()),
            ),
          ).then(
            (value) => context.read<TasklistBloc>().add(
                  TasklistCreateNewTask(value),
                ),
          );
        }
      },
      builder: (context, state) {
        if (state is TasklistInitial || state is TasklistLoading) {
          return const Center(
            child: CustomCircularProgressIndicator(
              size: 25.0,
            ),
          );
        }
        if (state is TasklistError) {
          return const Center(
            child: CustomErrorIcon(),
          );
        }
        return BaseScreen(
          hideNavigationBar: true,
          hideFloatingActionButton: false,
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: CustomHeaderBar(
                      upperChild: Container(
                        constraints: BoxConstraints.tight(
                          Size(
                            context.mediaQuery.size.width * 0.3,
                            context.mediaQuery.size.height * 0.03,
                          ),
                        ),
                        decoration: ShapeDecoration(
                          color: calculateColor(
                              (state as TasklistSubscription).project!.endDate),
                          shape: const RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(ROUND_CORNER),
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          calculateDaysLeft(
                            (state).project!.endDate,
                          ),
                        ),
                      ),
                      atHomePage: false,
                      bottomChild: Text((state).project!.name),
                      onPressed: (context) =>
                          context.read<NavigationBloc>().add(
                                const NavigateToProjectsList(),
                              ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          context.mediaQuery.size.width * RATIO_PADDING + 5.0,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('Leader',
                                      style: context.textTheme.titleSmall),
                                  SizedBox(
                                      width: context.mediaQuery.size.width *
                                          RATIO_PADDING),
                                  FutureBuilder(
                                    future: context
                                        .read<TasklistBloc>()
                                        .imageUrl(
                                            (state).project!.leaderImageUrl),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return CustomAvatarWidget(
                                          imageUrl: snapshot.data!,
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Icon(
                                            Icons.error_outline_rounded,
                                            size: 20.0,
                                            color: context.colorScheme.error,
                                          ),
                                        );
                                      }
                                      return const Center(
                                        child: CustomCircularProgressIndicator(
                                          size: 25.0,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              MiniNav(
                                totalFiles: state.project!.totalFileLinks,
                                totalNotes: state.project!.totalFileLinks,
                                totalUnreadMessages: 2,
                              )
                            ],
                          ),
                          SizedBox(
                              height: context.mediaQuery.size.width *
                                  RATIO_PADDING),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Assignee",
                                style: context.textTheme.titleSmall,
                              ),
                              Text(
                                "Completed",
                                style: context.textTheme.titleSmall,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder(
                                future: context
                                    .read<TasklistBloc>()
                                    .assigneeAvatars(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Row(
                                      children: [
                                        for (var avatar
                                            in snapshot.data as List<String>)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: context
                                                      .mediaQuery.size.width *
                                                  0.01,
                                            ),
                                            child: CustomAvatarWidget(
                                              imageUrl: avatar,
                                              size: context
                                                      .mediaQuery.size.width *
                                                  (RATIO_MARGIN + 0.01),
                                            ),
                                          ),
                                      ],
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Icon(
                                        Icons.error_outline_rounded,
                                        size: 20.0,
                                        color: context.colorScheme.error,
                                      ),
                                    );
                                  }
                                  return const Center(
                                    child: CustomCircularProgressIndicator(
                                      size: 25.0,
                                    ),
                                  );
                                },
                              ),
                              const SwitchButton()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTag(
                    tags: state.project!.tags,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          context.mediaQuery.size.width * RATIO_PADDING + 5.0,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: context.mediaQuery.size.width *
                                  RATIO_PADDING),
                          Date(
                            startDate: state.project!.startDate,
                            endDate: state.project!.endDate,
                          ),
                          SizedBox(
                              height:
                                  context.mediaQuery.size.width * RATIO_SPACE),
                          Progress(
                            progress: state.project!.activitiesCompleted /
                                state.project!.totalActivities,
                            tasksCompleted: state.project!.tasksCompleted,
                            totalTasks: state.project!.tasks.length,
                            activitiesCompleted:
                                state.project!.activitiesCompleted,
                            totalActivities: state.project!.totalActivities,
                            mostActive: state.project!.mostActiveMemebers,
                          ),
                          SizedBox(
                              height:
                                  context.mediaQuery.size.width * RATIO_SPACE),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ListSubTask(
                      tasks: state.project!.tasks,
                    ),
                  ),
                ],
              ),
              if (state.project!.tasks.isNotEmpty)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      DotsIndicator(
                        dotsCount: state.project!.tasks.length,
                        position: state.currentPage,
                        decorator: const DotsDecorator(
                          color: GREY,
                          activeColor: BLACK,
                        ),
                      ),
                      Container(
                        height: 12,
                        width: context.mediaQuery.size.width / 3,
                        decoration: const BoxDecoration(
                          color: PURPLE,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              MEDIUM_CORNER,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
