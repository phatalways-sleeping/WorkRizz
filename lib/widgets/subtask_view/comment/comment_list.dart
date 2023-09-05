import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_dialog.dart';
import 'package:task_managing_application/widgets/subtask_view/comment/switch.dart';

part 'comment_entry.dart';
part 'comment_widget.dart';

// ignore: must_be_immutable
class Comment extends StatefulWidget {
  Comment({super.key, required this.isAssigned, required this.isLeader});
  final bool isAssigned;
  final bool isLeader;
  int items = 2;

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool isAddingComment = false; // Track if "Write a Comment" is tapped
  String replyUsername = "";
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Comment (${widget.items.toString()})',
              style: context.textTheme.labelMedium),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const SwitchButton()
              InkWell(
                onTap: () {
                  setState(() {
                    isAddingComment = true; // Enable comment entry
                  });
                },
                child: Text('Write a Comment',
                    style: context.textTheme.titleSmall?.copyWith(
                      decoration: TextDecoration.underline,
                      shadows: [const Shadow(color: PURPLE, offset: Offset(0, -3))],
                      color: Colors.transparent,
                      decorationColor: PURPLE,
                      decorationThickness: 1.5,
                    )),
              ),
            ],
          ),
        ],
      ),
      if (isAddingComment)
        CommentEntryWidget(
          replyUsername: replyUsername,
          onCommentAdded: () {
            setState(() {
              isAddingComment = false;
              widget.items++; // Disable comment entry
            });
          },
          onCommentCancelled: () {
            setState(() {
              isAddingComment = false; // Disable comment entry
            });
          },
        ),
      ListView.builder(
        shrinkWrap: true,
        itemCount: widget.items,
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
                      onLeftPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      onRightPressed: () {
                        Navigator.of(context).pop(true);
                      }));
            },
            dismissThresholds: const {
              DismissDirection.endToStart: 0.1,
            },
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                widget.items--;
              });
              // // Then show a snackbar.
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     duration: const Duration(seconds: 1),
              //     backgroundColor: lightColorScheme.outline,
              //     content: const Text("Remove successfully!")));
            },
            key: UniqueKey(),
            child: CommentWidget(
              triggerReplied: (value) {
                setState(() {
                  isAddingComment = true;
                  replyUsername = value;
                });
              },
              isAssigned: widget.isAssigned,
              isReplied: false,
              isSolved: true,
            ),
          );
        },
      ),
    ]);
  }
}
