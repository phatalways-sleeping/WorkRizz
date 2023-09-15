part of 'tasklist_view.dart';

class ListSubTask extends StatefulWidget {
  const ListSubTask({
    super.key,
    required this.tasks,
  });

  final List<TaskSmallInformation> tasks;

  @override
  State<ListSubTask> createState() => _ListSubTaskState();
}

class _ListSubTaskState extends State<ListSubTask> {
  late final PageController _pageController = PageController(
    initialPage: context.read<TasklistBloc>().state.currentPage == -1
        ? 0
        : context.read<TasklistBloc>().state.currentPage,
  );

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TasklistBloc, TasklistState, int>(
      selector: (state) => state.currentPage,
      builder: (context, page) {
        if (widget.tasks.isEmpty || page < 0) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: context.mediaQuery.size.width * RATIO_MARGIN,
            ),
            child: Center(
              child: Text(
                'Start by adding a task',
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
            controller: _pageController,
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
                  widget.tasks.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(
                      horizontal:
                          context.mediaQuery.size.width * RATIO_PADDING + 5.0,
                    ),
                    child: SubTaskWidget(
                      task: widget.tasks[index],
                      currentPage: index + 1,
                      totalPage: widget.tasks.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
