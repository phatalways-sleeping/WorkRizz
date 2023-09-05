part of 'comment_list.dart';

// ignore: must_be_immutable
class CommentWidget extends StatefulWidget {
  CommentWidget({
    Key? key,
    required this.isAssigned,
    required this.isReplied,
    required this.isSolved,
    required this.triggerReplied,
    this.isReplying = false,
    this.replyUsername = "",
  }) : super(key: key);

  final bool isAssigned;
  bool isSolved;
  bool isReplied;
  final bool isReplying;
  final String replyUsername;
  final Function(String)? triggerReplied;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final String imageUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg';

  final String username = 'djfdlajl';

  @override
  Widget build(BuildContext context) {
    double opacity = widget.isReplied ? 0.6 : 1.0;
    return Opacity(
      opacity: opacity,
      child: Container(
        margin: EdgeInsets.only(top: context.mediaQuery.size.width * 0.01),
        child: Column(
          // align right
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAvatarWidget(
                  imageUrl: imageUrl,
                ),
                SizedBox(
                    width: context.mediaQuery.size.width * RATIO_PADDING / 2),
                // underlined text
                Expanded(
                  child: Container(
                    // constraints: BoxConstraints(
                    //   minHeight: context.mediaQuery.size.height * 0.01,
                    //   maxHeight: context.mediaQuery.size.height * 0.11,
                    // ),
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
                        MediaQuery.of(context).size.width * RATIO_PADDING),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.isReplying)
                          Text("Replied to @${widget.replyUsername}",
                              style: context.textTheme.labelMedium
                                  ?.copyWith(color: GREEN)),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  ',
                          style: context.textTheme.titleSmall?.copyWith(
                            decoration: widget.isSolved
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
            widget.isSolved
                ? Row(children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        if (widget.isAssigned) {
                          setState(() {
                            widget.isSolved = !widget.isSolved;
                          });
                        }
                      },
                      child: Text(
                        'Solved',
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ])
                : Row(children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        if (widget.isAssigned && !widget.isReplied) {
                          setState(() {
                            widget.isReplied = true;
                            widget.triggerReplied?.call(username);
                          });
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
                          setState(() {
                            widget.isSolved = !widget.isSolved;
                          });
                        }
                      },
                      child: Text(
                        '  Solve',
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ]),
          ],
        ),
      ),
    );
  }
}
