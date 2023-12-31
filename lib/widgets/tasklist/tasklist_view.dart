import 'package:avatar_stack/avatar_stack.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/models/project/sub_task_small_info.dart';
import 'package:task_managing_application/models/project/task_small_info.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_dialog.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_input_dialog.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/email_dialog.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';
import 'package:task_managing_application/widgets/custom_item_widget/custom_item_widget.dart';
import 'package:task_managing_application/widgets/custom_tag/project_tag_widget.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_avatar.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_box.dart';
import 'package:task_managing_application/widgets/tasklist/delete_project_button.dart';
import 'package:task_managing_application/widgets/tasklist/edit_project_button.dart';
import 'package:task_managing_application/widgets/tasklist/other_options_button.dart';
import 'package:task_managing_application/widgets/tasklist/switch.dart';

part 'date.dart';
part 'mini_nav.dart';
part 'progress.dart';
part 'subtask_widget.dart';
part 'list_tag.dart';
part 'list_subtask.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        } else if (state is TasklistDeleteProjectState) {
          context.read<NavigationBloc>().add(
                const NavigateToProjectsList(),
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
        if (state is TasklistDeleteProjectState) {
          return const SizedBox.shrink();
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
                                totalFiles:
                                    state.project!.filesSmallInformations.fold(
                                  0,
                                  (previousValue, element) =>
                                      previousValue + element.files.length,
                                ),
                                projectName: state.project!.name,
                                threadId: state.project!.thread,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        AvatarStack(
                                          avatars: snapshot.data
                                              as List<NetworkImage>,
                                          width: context.mediaQuery.size.width *
                                              0.2,
                                          height:
                                              context.mediaQuery.size.width *
                                                  0.08,
                                        ),
                                        SizedBox(
                                          width: context.mediaQuery.size.width *
                                              RATIO_PADDING,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await showDialog<String>(
                                              context: context,
                                              builder: (context) => EmailDialog(
                                                  controller: _controller),
                                            ).then(
                                              (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return;
                                                }
                                                context
                                                    .read<TasklistBloc>()
                                                    .add(
                                                      TasklistAddNewAssignee(
                                                        assignee: value,
                                                      ),
                                                    );
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: 25.0,
                                            height: 25.0,
                                            decoration: const ShapeDecoration(
                                              color: Colors.black,
                                              shape: OvalBorder(),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 20.0,
                                            ),
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
                              const SwitchButton(),
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
                            progress: (state.project!.taskSmallInformations
                                        .fold(
                                            0,
                                            (previousValue, element) =>
                                                previousValue +
                                                element.subTaskSmallInformations
                                                    .length) ==
                                    0)
                                ? 0
                                : (state.project!.activitiesCompleted /
                                    state.project!.taskSmallInformations.fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue +
                                            element.subTaskSmallInformations
                                                .length)),
                            tasksCompleted: state.project!.tasksCompleted,
                            totalTasks: state.project!.tasks.length,
                            activitiesCompleted:
                                state.project!.taskSmallInformations.fold(
                              0,
                              (previousValue, element) =>
                                  previousValue +
                                  element.subTaskSmallInformations
                                      .where((element) => element.isCompleted)
                                      .length,
                            ),
                            totalActivities:
                                state.project!.taskSmallInformations.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        element
                                            .subTaskSmallInformations.length),
                            mostActive: state.project!.mostActiveMemebers,
                          ),
                          SizedBox(
                              height:
                                  context.mediaQuery.size.width * RATIO_SPACE),
                        ],
                      ),
                    ),
                  ),
                  if (state is! TasklistSubscriptionLoading)
                    SliverToBoxAdapter(
                      child: ListSubTask(
                        tasks: state.project!.taskSmallInformations,
                      ),
                    )
                  else
                    SliverToBoxAdapter(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ShimmerBox(
                          height: context.mediaQuery.size.height * 0.1,
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                context.mediaQuery.size.width * RATIO_PADDING +
                                    5.0,
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10.0,
                        ),
                        itemCount: 3,
                      ),
                    ),
                ],
              ),
              if (state.project!.tasks.isNotEmpty &&
                  context.watch<TasklistBloc>().state.currentPage >= 0)
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
