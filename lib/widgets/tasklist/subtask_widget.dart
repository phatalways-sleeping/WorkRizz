part of 'tasklist_view.dart';

class SubTaskWidget extends StatefulWidget {
  const SubTaskWidget({
    super.key,
    required this.taskId,
    required this.currentPage,
    required this.totalPage,
  });

  final String taskId;
  final int currentPage;
  final int totalPage;

  @override
  State<SubTaskWidget> createState() => _SubTaskWidgetState();
}

class _SubTaskWidgetState extends State<SubTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Task>(
      stream: context.read<TasklistBloc>().subTaskSmallInformationStream(
            widget.taskId,
          ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ShimmerSubTaskWidget();
        }
        if (!snapshot.hasData) {
          return const ShimmerSubTaskWidget();
        }
        final task = snapshot.data as Task;
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
                    name: '${widget.currentPage}/${widget.totalPage}',
                  ),
                  SizedBox(
                      width: context.mediaQuery.size.width * RATIO_PADDING),
                  Text(
                    task.name,
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
              titleSpacing: 0.0,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              toolbarHeight:
                  context.mediaQuery.size.width * RATIO_PADDING * 2.5,
            ),
            ...List.generate(
              task.subTasks.length,
              (index) => SubTaskInfo(
                subTaskSmallInformation: task.subTaskSmallInformations[index],
                taskId: widget.taskId,
              ),
            ),
            ElevatedButton(
              onPressed: () => context.read<NavigationBloc>().add(
                    NavigateToSubTaskCreate(
                      widget.taskId,
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
                  SizedBox(
                      width: context.mediaQuery.size.width * RATIO_PADDING),
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
      },
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
      child: CustomItemWidget(
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
        isFixed: false,
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
    );
  }
}
