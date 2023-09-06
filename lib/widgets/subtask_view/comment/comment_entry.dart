part of 'comment_list.dart';

class CommentEntryWidget extends StatefulWidget {
  final void Function(
    BuildContext context,
    TextEditingController controller,
  ) onCommentAdded;
  final void Function(
    BuildContext context,
  ) onCommentCancelled;
  final String replyUsername;

  const CommentEntryWidget({
    super.key,
    required this.onCommentAdded,
    required this.onCommentCancelled,
    required this.replyUsername,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CommentEntryWidgetState createState() => _CommentEntryWidgetState();
}

class _CommentEntryWidgetState extends State<CommentEntryWidget> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: context.mediaQuery.size.width * 0.02,
      ),
      child: Column(
        children: [
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'Enter your comment...',
              labelText: widget.replyUsername.isNotEmpty
                  ? 'Reply to @${widget.replyUsername}'
                  : null,
              labelStyle: context.textTheme.titleMedium,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: BLACK,
                  width: BORDER_WIDTH,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: BLACK,
                  width: BORDER_WIDTH,
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Submit the comment and notify the parent
                  widget.onCommentCancelled(context);
                },
                style: const ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(
                    PINK,
                  ),
                  splashFactory: InkSparkle.splashFactory,
                  animationDuration: Duration(
                    seconds: 2,
                  ),
                  tapTargetSize: MaterialTapTargetSize.padded,
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(MEDIUM_CORNER),
                      ),
                      // no right borderd
                      side: BorderSide.none,
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                    PALE,
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: context.textTheme.labelMedium,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Submit the comment and notify the parent
                  widget.onCommentAdded(
                    context,
                    _commentController,
                  );
                },
                style: const ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(
                    PURPLE,
                  ),
                  splashFactory: InkSparkle.splashFactory,
                  animationDuration: Duration(
                    seconds: 2,
                  ),
                  tapTargetSize: MaterialTapTargetSize.padded,
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(MEDIUM_CORNER),
                      ),
                      // no right borderd
                      side: BorderSide.none,
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                    GREEN,
                  ),
                ),
                child: Text(
                  'Submit',
                  style: context.textTheme.labelMedium,
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
