part of 'tasklist_view.dart';

// ignore: must_be_immutable
class ListSubTask extends StatelessWidget {
  const ListSubTask({
    super.key,
    required this.tasks,
  });

  final List<String> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: context.mediaQuery.size.height * 0.48,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: context.mediaQuery.size.width * RATIO_MARGIN,
        ),
        child: InkWell(
          onTap: () => context.read<TasklistBloc>().add(
                const TasklistOpenTaskCreateDialog(),
              ),
          splashColor: Colors.transparent,
          overlayColor: const MaterialStatePropertyAll(
            Colors.transparent,
          ),
          child: Text(
            'Start by adding a new task here',
            style: context.textTheme.displaySmall?.copyWith(
              color: context.colorScheme.error,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      );
    }
    return Container(
      constraints: BoxConstraints(
        maxHeight: context.mediaQuery.size.height * 0.48,
      ),
      margin: EdgeInsets.only(
        bottom: context.mediaQuery.size.width * RATIO_MARGIN,
      ),
      child: PageView.custom(
        padEnds: true,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) => context.read<TasklistBloc>().add(
              TasklistChangePage(
                page: index,
              ),
            ),
        childrenDelegate: SliverChildListDelegate(
          [
            ...List.generate(
              tasks.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                        context.mediaQuery.size.width * RATIO_PADDING + 5.0),
                child: SubTask(
                  taskId: tasks[index],
                  currentPage: index + 1,
                  totalPage: tasks.length,
                ),
              ),
            ),
            // SizedBox(
            //   height: context.mediaQuery.size.height * RATIO_MARGIN,
            // ),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: const ButtonStyle(
            //     overlayColor: MaterialStatePropertyAll(
            //       PURPLE,
            //     ),
            //     splashFactory: InkSparkle.splashFactory,
            //     animationDuration: Duration(
            //       seconds: 2,
            //     ),
            //     tapTargetSize: MaterialTapTargetSize.padded,
            //     shape: MaterialStatePropertyAll(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.horizontal(
            //           left: Radius.circular(MEDIUM_CORNER),
            //         ),
            //         // no right borderd
            //         side: BorderSide.none,
            //       ),
            //     ),
            //     backgroundColor: MaterialStatePropertyAll(
            //       PINK,
            //     ),
            //   ),
            //   child: SvgPicture.string(SvgAssets.add),
            // ),
            // SizedBox(
            //   height: context.mediaQuery.size.height * 0.2,
            // ),
          ],
        ),
      ),
    );
  }
}
