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

class SubTaskController {
  void Function(bool)? changeColor;
}

class SubTaskInfo extends StatefulWidget {
  const SubTaskInfo({
    super.key,
    required this.subTaskSmallInformation,
    required this.taskId,
  });

  final SubTaskSmallInformation subTaskSmallInformation;
  final String taskId;

  @override
  State<SubTaskInfo> createState() => _SubTaskInfoState();
}

class _SubTaskInfoState extends State<SubTaskInfo> {
  final SubTaskController _controller = SubTaskController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: context.mediaQuery.size.width * 0.01),
      child: CustomItemWidget(
        firstChild: CheckboxWidget(
          checkState: widget.subTaskSmallInformation.isCompleted,
          onChanged: (value, context) {
            if (value! == true) {
              context.read<TasklistBloc>().add(
                    TasklistMarkSubTaskAsCompleted(
                      taskId: widget.taskId,
                      subTaskId: widget.subTaskSmallInformation.id,
                      assigneeImageUrl:
                          widget.subTaskSmallInformation.assigneeImageUrl,
                    ),
                  );
            }
            setState(() {
              _controller
                  .changeColor!(widget.subTaskSmallInformation.isCompleted);
            });
          },
        ),
        controller: _controller,
        isFixed: false,
        isDone: widget.subTaskSmallInformation.isCompleted,
        name: widget.subTaskSmallInformation.name,
        subtext: '${widget.subTaskSmallInformation.points}pt',
        secondChild: FutureBuilder(
          future: context
              .read<TasklistBloc>()
              .imageUrl(widget.subTaskSmallInformation.assigneeImageUrl),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ShimmerAvatar(size: 24.0);
            }
            if (!snapshot.hasData) {
              return const ShimmerAvatar(size: 24.0);
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
