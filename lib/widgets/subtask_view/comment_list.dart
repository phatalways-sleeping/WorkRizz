part of 'subtask_view.dart';

class Comment extends StatelessWidget {
  const Comment({super.key, required this.isAssigned});
  final bool isAssigned;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Comment (2)', style: context.textTheme.labelMedium),
            InkWell(
              onTap: () {},
              child: Text('Write a Comment',
                  style: context.textTheme.titleSmall?.copyWith(
                    decoration: TextDecoration.underline,
                    shadows: [
                      const Shadow(color: PURPLE, offset: Offset(0, -3))
                    ],
                    color: Colors.transparent,
                    decorationColor: PURPLE,
                    decorationThickness: 1.5,
                  )),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          // block scroll,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CommentWidget(
              isAssigned: isAssigned,
              isReplied: true,
              isSolved: true,
            );
          },
        ),
      ],
    );
  }
}

class CommentWidget extends StatefulWidget {
  CommentWidget({
    Key? key,
    required this.isAssigned,
    required this.isReplied,
    required this.isSolved,
  }) : super(key: key);

  final bool isAssigned;
  bool isSolved;
  bool isReplied;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final String imageUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg';

  final String username = 'John Doe';
  // late bool isSolved;
  // late bool isReplied;


  @override
  // void initState() {
  //   super.initState();
  //   isSolved = widget.isSolved;
  //   isReplied = widget.isReplied;
  // }

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
                    constraints: BoxConstraints(
                      minHeight: context.mediaQuery.size.height * 0.01,
                      maxHeight: context.mediaQuery.size.height * 0.09,
                    ),
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
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  ',
                      style: context.textTheme.titleSmall?.copyWith(
                        decoration:
                            widget.isSolved ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(children: [
              const Spacer(),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Reply  ',
                  style: bodySmall,
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
                child: const Text(
                  '  Solve',
                  style: bodySmall,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
