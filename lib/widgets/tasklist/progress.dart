part of 'tasklist_view.dart';

class Progress extends StatelessWidget {
  const Progress({
    super.key,
    required this.progress,
    required this.totalActivities,
    required this.totalTasks,
    required this.tasksCompleted,
    required this.activitiesCompleted,
    required this.mostActive,
  });

  final double progress;
  final int totalActivities;
  final int totalTasks;
  final int tasksCompleted;
  final int activitiesCompleted;
  final List<String> mostActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(
        Size(
          context.mediaQuery.size.width,
          context.mediaQuery.size.height * 0.1,
        ),
      ),
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: BLACK,
            width: BORDER_WIDTH,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(MEDIUM_CORNER),
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: context.mediaQuery.size.width * RATIO_PADDING,
        right: context.mediaQuery.size.width * RATIO_PADDING,
        bottom: context.mediaQuery.size.width * RATIO_PADDING * 1.4,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: const ShapeDecoration(
              color: GREEN,
              shape: CircleBorder(
                side: BorderSide(
                  color: BLACK,
                  width: BORDER_WIDTH,
                ),
              ),
            ),
            // size bound its child
            padding: EdgeInsets.all(
              context.mediaQuery.size.width * RATIO_PADDING,
            ),
            child: SizedBox(
              child: Text(
                '${(progress * 100).toInt()}%',
                style: context.textTheme.titleSmall,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$tasksCompleted/$totalTasks',
                style: context.textTheme.titleLarge,
              ),
              Text(
                "Tasks",
                style: context.textTheme.bodyLarge,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$activitiesCompleted/$totalActivities',
                style: context.textTheme.titleLarge,
              ),
              Text(
                "Activities",
                style: context.textTheme.bodyLarge,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FutureBuilder(
                future: context.read<TasklistBloc>().mostActiveMembers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AvatarStack(
                      height:
                          context.mediaQuery.size.width * (RATIO_MARGIN + 0.04),
                      width: context.mediaQuery.size.width * 0.2,
                      avatars: snapshot.data as List<NetworkImage>,
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Icon(
                        Icons.error_outline_rounded,
                        size: context.mediaQuery.size.width * RATIO_PADDING,
                        color: context.colorScheme.error,
                      ),
                    );
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: CustomCircularProgressIndicator(
                        size:
                            context.mediaQuery.size.width * RATIO_PADDING * 1.2,
                      ),
                    ),
                  );
                },
              ),
              Text(
                "Most Active",
                style: context.textTheme.bodyMedium,
              )
            ],
          ),
        ],
      ),
    );
  }
}
