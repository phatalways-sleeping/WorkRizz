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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'No tasks yet',
              style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSecondary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                overlayColor: const MaterialStatePropertyAll(
                  PURPLE,
                ),
                splashFactory: InkSparkle.splashFactory,
                animationDuration: const Duration(
                  seconds: 2,
                ),
                tapTargetSize: MaterialTapTargetSize.padded,
                shape: const MaterialStatePropertyAll(
                  CircleBorder(),
                ),
                backgroundColor: const MaterialStatePropertyAll(
                  PINK,
                ),
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                    horizontal: context.mediaQuery.size.width * 0.02,
                    vertical: context.mediaQuery.size.width * 0.02,
                  ),
                ),
                alignment: Alignment.center,
              ),
              child: SvgPicture.string(
                SvgAssets.add,
                width: 16.0,
                height: 16.0,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.onSecondary,
                  BlendMode.srcATop,
                ),
              ),
            ),
          ],
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
