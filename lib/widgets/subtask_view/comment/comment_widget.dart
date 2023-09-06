part of 'comment_list.dart';

// ignore: must_be_immutable
class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.isAssigned,
    required this.commentId,
    required this.commentOwnerUsername,
  });

  final bool isAssigned;
  final String commentId;
  final String commentOwnerUsername;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CommentModel>(
        stream: context.read<SubtaskViewBloc>().commentStream(widget.commentId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Shimmer(
                linearGradient: shimmer_gradient,
                child: ShimmerLoading(
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Shimmer(
                linearGradient: shimmer_gradient,
                child: ShimmerLoading(
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }
          final commentModel = snapshot.data as CommentModel;
          return Opacity(
            opacity: commentModel.isReplied ? 0.6 : 1.0,
            child: Container(
              margin: EdgeInsets.only(
                top: context.mediaQuery.size.width * 0.01,
              ),
              child: Column(
                // align right
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamCustomAvatarWidget(
                        userId: commentModel.commenter,
                      ),
                      SizedBox(
                        width: context.mediaQuery.size.width * RATIO_PADDING,
                      ),
                      // underlined text
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: context.mediaQuery.size.width * 0.01),
                          decoration: BoxDecoration(
                            // border black, size 1, round corner 12
                            border: Border.all(
                              color: BLACK,
                              width: BORDER_WIDTH,
                            ),
                            borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                          ),
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width *
                                  RATIO_PADDING),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (commentModel.isReplied)
                                Text(
                                  "Replied to @${commentModel.repliedToUsername}",
                                  style:
                                      context.textTheme.labelMedium?.copyWith(
                                    color: GREEN,
                                  ),
                                ),
                              Text(
                                commentModel.comment,
                                style: context.textTheme.titleSmall?.copyWith(
                                  decoration: commentModel.solved
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  commentModel.solved
                      ? Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                if (widget.isAssigned) {
                                  context.read<SubtaskViewBloc>().add(
                                        SubTaskMarkCommentUnsolvedEvent(
                                          commentModel,
                                        ),
                                      );
                                }
                              },
                              child: Text(
                                'Solved',
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                if (widget.isAssigned &&
                                    !commentModel.isReplied) {
                                  context.read<SubtaskViewBloc>().add(
                                        SubTaskRequestReplyToCommentEvent(
                                          replyToUsername:
                                              widget.commentOwnerUsername,
                                        ),
                                      );
                                }
                              },
                              child: Text(
                                'Reply  ',
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                            const Icon(Icons.lens, size: 5, color: BLACK),
                            InkWell(
                              onTap: () {
                                if (widget.isAssigned) {
                                  context.read<SubtaskViewBloc>().add(
                                        SubTaskMarkCommentSolvedEvent(
                                          commentModel,
                                        ),
                                      );
                                }
                              },
                              child: Text(
                                '  Solve',
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          );
        });
  }
}
