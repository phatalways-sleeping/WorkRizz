import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/states/subtask_view_bloc/subtask_view_bloc.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_dialog.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_config.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_loading.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_wrapper.dart';
import 'package:task_managing_application/widgets/subtask_view/comment/stream_custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/widgets.dart';

part 'comment_entry.dart';
part 'comment_widget.dart';

// ignore: must_be_immutable
class Comment extends StatefulWidget {
  const Comment({
    super.key,
    required this.isAssigned,
    required this.isLeader,
    required this.comments,
  });
  final bool isAssigned;
  final bool isLeader;
  final List<String> comments;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Comment (${widget.comments.length})',
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 16.0,
              ),
            ),
            if (context.watch<SubtaskViewBloc>().state
                is SubTaskViewSuccessPendingToUpdateComment) ...[
              const SizedBox(width: 10.0),
              SizedBox(
                width: 15.0,
                height: 15.0,
                child: CustomCircularProgressIndicator(
                  color: context.colorScheme.primary,
                ),
              ),
            ],
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => context.read<SubtaskViewBloc>().add(
                        const SubTaskRequestInputSubTaskCommentEvent(),
                      ),
                  child: Text(
                    'Write a Comment',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontSize: 14.0,
                      decoration: TextDecoration.underline,
                      shadows: [
                        const Shadow(color: PURPLE, offset: Offset(0, -3))
                      ],
                      color: Colors.transparent,
                      decorationColor: PURPLE,
                      decorationThickness: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        if (context.read<SubtaskViewBloc>().state
            is SubTaskViewSuccessRequestComment)
          CommentEntryWidget(
            replyUsername: '',
            onCommentAdded: (context, controller) =>
                context.read<SubtaskViewBloc>().add(
                      SubTaskInputSubTaskCommentEvent(
                        controller.text.trim(),
                      ),
                    ),
            onCommentCancelled: (context) =>
                context.read<SubtaskViewBloc>().add(
                      const SubTaskCancelRequestInputSubTaskCommentEvent(),
                    ),
          ),
        if (context.read<SubtaskViewBloc>().state
            is SubTaskViewSuccessRequestReplyComment)
          CommentEntryWidget(
            onCommentAdded: (context, controller) =>
                context.read<SubtaskViewBloc>().add(
                      SubTaskReplyToCommentEvent(
                        comment: controller.text.trim(),
                      ),
                    ),
            onCommentCancelled: (context) =>
                context.read<SubtaskViewBloc>().add(
                      const SubTaskCancelRequestInputSubTaskCommentEvent(),
                    ),
            replyUsername: (context.watch<SubtaskViewBloc>().state
                    as SubTaskViewSuccessRequestReplyComment)
                .replyUsername,
          ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.comments.length,
          // block scroll,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              background: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                    color: BLACK),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 15),
                    child: const Icon(Icons.delete, color: WHITE),
                  ),
                ),
              ),
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: "Remove this Comment",
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
                ).then((value) async {
                  if (value != null && value) {
                    context.read<SubtaskViewBloc>().add(
                        SubTaskRemoveSubTaskCommentEvent(
                            widget.comments[index]));
                  }
                  return null;
                });
              },
              dismissThresholds: const {
                DismissDirection.endToStart: 0.1,
              },
              onDismissed: (direction) {
                // Remove the item from the data source.
                // setState(() {
                //   widget.items--;
                // });
                // // Then show a snackbar.
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     duration: const Duration(seconds: 1),
                //     backgroundColor: lightColorScheme.outline,
                //     content: const Text("Remove successfully!")));
              },
              key: UniqueKey(),
              child: CommentWidget(
                commentId: widget.comments[index],
                isAssigned: widget.isAssigned,
              ),
            );
          },
        ),
      ],
    );
  }
}
