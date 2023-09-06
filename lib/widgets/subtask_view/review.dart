part of 'subtask_view.dart';

class Review extends StatelessWidget {
  const Review({
    super.key,
    required this.isLeader,
    required this.progress,
    required this.grade,
    required this.leaderReview,
  });
  final bool isLeader;
  final double progress;
  final int grade;
  final String leaderReview;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review',
          style: context.textTheme.labelMedium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: context.mediaQuery.size.width * 0.4,
              margin: EdgeInsets.only(
                top: context.mediaQuery.size.width * 0.01,
              ),
              decoration: BoxDecoration(
                // border black, size 1, round corner 12
                border: Border.all(
                  color: BLACK,
                  width: BORDER_WIDTH,
                ),
                borderRadius: BorderRadius.circular(MEDIUM_CORNER),
              ),
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * RATIO_PADDING,
                horizontal:
                    MediaQuery.of(context).size.width * RATIO_PADDING * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isLeader
                      ? TextInput(
                          suffixText: "%",
                          color: PINK,
                          initialNumber: (progress).toInt(),
                          listener: (context, controller) => context
                              .read<SubtaskViewBloc>()
                              .add(
                                SubTaskInputProgressEvent(
                                  double.parse(controller.text.trim()) / 100.0,
                                ),
                              ),
                        )
                      : Text(
                          '${(progress).toStringAsFixed(0)}%',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: BLACK,
                            fontSize: 36.0,
                          ),
                        ),
                  SizedBox(
                      width: context.mediaQuery.size.width * RATIO_PADDING),
                  Text(
                    'Completed',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: BLACK,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: context.mediaQuery.size.width * 0.4,
                margin:
                    EdgeInsets.only(top: context.mediaQuery.size.width * 0.01),
                decoration: BoxDecoration(
                  // border black, size 1, round corner 12
                  border: Border.all(
                    color: BLACK,
                    width: BORDER_WIDTH,
                  ),
                  borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * RATIO_PADDING,
                    horizontal:
                        MediaQuery.of(context).size.width * RATIO_PADDING * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isLeader
                        ? TextInput(
                            suffixText: "/10",
                            color: PALE,
                            initialNumber: grade,
                            listener: (context, controller) =>
                                context.read<SubtaskViewBloc>().add(
                                      SubTaskInputGradeEvent(
                                        int.parse(controller.text.trim()),
                                      ),
                                    ),
                          )
                        : Text(
                            '${(grade / 10.0)}/10',
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: BLACK,
                              fontSize: 36.0,
                            ),
                          ),
                    SizedBox(
                        width: context.mediaQuery.size.width * RATIO_PADDING),
                    Text('Points',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: BLACK,
                          fontSize: 16.0,
                        )),
                  ],
                )),
          ],
        ),
        SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
        isLeader
            ? DescriptionInput(
              forLeaderComment: true,
                label: "Leader's Review",
                showLabel: true,
                initialValue: leaderReview,
                listener: (context, controller) =>
                    context.read<SubtaskViewBloc>().add(
                          SubTaskInputLeaderCommentEvent(
                            controller.text.trim(),
                          ),
                        ),
              )
            : Container(
                // width: max available width, finite
                constraints: BoxConstraints(
                  minHeight: context.mediaQuery.size.height * 0.1,
                  minWidth: context.mediaQuery.size.width,
                ),
                margin:
                    EdgeInsets.only(top: context.mediaQuery.size.width * 0.01),
                decoration: BoxDecoration(
                  // border black, size 1, round corner 12
                  border: Border.all(
                    color: BLACK,
                    width: BORDER_WIDTH,
                  ),
                  borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                ),
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * RATIO_PADDING,
                ),
                child: Text(
                    leaderReview.isEmpty ? 'No review yet' : leaderReview,
                    style: context.textTheme.titleSmall),
              ),
        SizedBox(
          height: context.mediaQuery.size.width * RATIO_SPACE,
        ),
        // CustomInputField(label: "", controller: _titleController, keyboardType: TextInputType.number),
      ],
    );
  }
}
