part of 'tasklist_view.dart';

class SubTaskWidget extends StatelessWidget {
  const SubTaskWidget({
    super.key,
    required this.task,
    required this.currentPage,
    required this.totalPage,
  });

  final TaskSmallInformation task;
  final int currentPage;
  final int totalPage;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      clipBehavior: Clip.hardEdge,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: context.mediaQuery.size.width * RATIO_PADDING,
      ),
      children: [
        AppBar(
          title: Row(
            children: [
              TaskTag(
                color: GREY,
                name: '$currentPage/$totalPage',
              ),
              SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
              Text(
                task.name,
                style: context.textTheme.titleMedium,
              ),
              const Spacer(),
              if (context.watch<TasklistBloc>().state
                  is TasklistSubscriptionEditable)
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.zero,
                    ),
                    minimumSize: const MaterialStatePropertyAll(
                      Size(
                        60.0,
                        24.0,
                      ),
                    ),
                    maximumSize: const MaterialStatePropertyAll(
                      Size(
                        60.0,
                        24.0,
                      ),
                    ),
                    iconSize: MaterialStateProperty.all(
                      24.0,
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                    shadowColor: const MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                    elevation: const MaterialStatePropertyAll(
                      0.0,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: BLACK,
                  ),
                  onPressed: () async {
                    await showDialog<bool>(
                      context: context,
                      builder: (context) => CustomDialog(
                        title: "Remove this Task",
                        leftText: "No",
                        rightText: "Yes",
                        leftColor: PURPLE,
                        rightColor: PINK,
                        focusleftColor: PALE,
                        focusrightColor: GREEN,
                        onLeftPressed: (context) {
                          Navigator.of(context).pop(false);
                        },
                        onRightPressed: (context) {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ).then(
                      (value) {
                        if (value == null) {
                          return;
                        }
                        if (value == true) {
                          context.read<TasklistBloc>().add(
                                TasklistDeleteTask(
                                  task.id,
                                ),
                              );
                        }
                      },
                    );
                  },
                ),
            ],
          ),
          titleSpacing: 0.0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          toolbarHeight: context.mediaQuery.size.width * RATIO_PADDING * 2.5,
        ),
        ...List.generate(
          task.subTaskSmallInformations.length,
          (index) => SubTaskInfo(
            subTaskSmallInformation: task.subTaskSmallInformations[index],
            taskId: task.id,
          ),
        ),
        ElevatedButton(
          onPressed: () => context.read<NavigationBloc>().add(
                NavigateToSubTaskCreate(
                  task.id,
                ),
              ),
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                side: const BorderSide(
                  color: BLACK,
                  width: 1,
                ),
              ),
            ),
            backgroundColor: const MaterialStatePropertyAll(
              BLACK,
            ),
            elevation: MaterialStateProperty.resolveWith(
              (states) => states.isPressed ? 4.0 : 0.0,
            ),
            overlayColor: const MaterialStatePropertyAll(
              GREEN,
            ),
            splashFactory: InkSparkle.splashFactory,
            animationDuration: const Duration(
              seconds: 2,
            ),
            tapTargetSize: MaterialTapTargetSize.padded,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
              SvgPicture.string(SvgAssets.addwhite),
              SizedBox(
                  width: context.mediaQuery.size.width *
                      (RATIO_SPACE + RATIO_SPACE)),
              Text(
                'Add subtask',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: WHITE,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SubTaskInfo extends StatelessWidget {
  const SubTaskInfo({
    super.key,
    required this.subTaskSmallInformation,
    required this.taskId,
  });

  final SubTaskSmallInformation subTaskSmallInformation;
  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: context.mediaQuery.size.width * 0.01),
      width: context.mediaQuery.size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CustomItemWidget(
              hideFirstChild: context.watch<TasklistBloc>().state
                  is TasklistSubscriptionEditable,
              onPressed: (context) => context.read<NavigationBloc>().add(
                    NavigateToSubTaskDetail(
                      subTaskSmallInformation.id,
                      taskId,
                    ),
                  ),
              firstChild: CheckboxWidget(
                checkState: subTaskSmallInformation.isCompleted,
                onChanged: (value, context) {
                  if (value == null) {
                    return;
                  }
                  if (value == true) {
                    context.read<TasklistBloc>().add(
                          TasklistMarkSubTaskAsCompleted(
                            taskId: taskId,
                            subTaskId: subTaskSmallInformation.id,
                            assigneeImageUrl:
                                subTaskSmallInformation.assigneeImageUrl,
                          ),
                        );
                  } else {
                    context.read<TasklistBloc>().add(
                          TasklistMarkSubTaskAsUncompleted(
                            taskId: taskId,
                            subTaskId: subTaskSmallInformation.id,
                            assigneeImageUrl:
                                subTaskSmallInformation.assigneeImageUrl,
                          ),
                        );
                  }
                },
              ),
              isDone: subTaskSmallInformation.isCompleted,
              name: subTaskSmallInformation.name,
              subtext: '${subTaskSmallInformation.points}pt',
              secondChild: FutureBuilder(
                future: context
                    .read<TasklistBloc>()
                    .imageUrl(subTaskSmallInformation.assigneeImageUrl),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const ShimmerAvatar(
                      radiusRatio: 0.06,
                    );
                  }
                  if (!snapshot.hasData) {
                    return const ShimmerAvatar(
                      radiusRatio: 0.06,
                    );
                  }
                  return CustomAvatarWidget(
                    imageUrl: snapshot.data as String,
                    size: context.mediaQuery.size.width * (RATIO_MARGIN + 0.01),
                  );
                },
              ),
            ),
          ),
          if (context.watch<TasklistBloc>().state
              is TasklistSubscriptionEditable) ...[
            SizedBox(
              width: context.mediaQuery.size.width * RATIO_PADDING,
            ),
            InkWell(
              child: Container(
                width: context.mediaQuery.size.width * 0.08,
                decoration: BoxDecoration(
                  color: PALE,
                  borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                  border: Border.all(
                    color: BLACK,
                    width: 1.0,
                  ),
                ),
                child: const Icon(
                  Icons.remove_outlined,
                  color: BLACK,
                ),
              ),
              onTap: () async {
                await showDialog<bool>(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: "Remove this Subtask",
                    leftText: "No",
                    rightText: "Yes",
                    leftColor: PURPLE,
                    rightColor: PINK,
                    focusleftColor: PALE,
                    focusrightColor: GREEN,
                    onLeftPressed: (context) {
                      Navigator.of(context).pop(false);
                    },
                    onRightPressed: (context) {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ).then(
                  (value) {
                    if (value == null) {
                      return;
                    }
                    if (value == true) {
                      context.read<TasklistBloc>().add(
                            TasklistDeleteSubTask(
                              subTaskId: subTaskSmallInformation.id,
                              taskId: taskId,
                            ),
                          );
                    }
                  },
                );
              },
            ),
          ]
        ],
      ),
    );
  }
}
