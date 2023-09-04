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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MEDIUM_CORNER),
        border: Border.all(color: BLACK, width: BORDER_WIDTH),
      ),
      padding:
          EdgeInsets.all(MediaQuery.of(context).size.width * RATIO_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              color: GREEN,
              shape: BoxShape.circle,
              border: Border.all(color: BLACK, width: BORDER_WIDTH),
            ),
            // size bound its child
            padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * RATIO_PADDING),
            child: SizedBox(
              child: Text(
                '${(progress * 100).toInt()}%',
                style: context.textTheme.titleSmall,
              ),
            ),
          ),
          Column(
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
