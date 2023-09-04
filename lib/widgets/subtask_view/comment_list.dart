part of 'subtask_view.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Comment (2)', style: context.textTheme.labelMedium),
            Text('Write a Comment', style: context.textTheme.titleSmall?.copyWith(
              decoration: TextDecoration.underline,
              shadows: [
                        const Shadow(color: PURPLE, offset: Offset(0, -3))
                      ],
                      color: Colors.transparent,
                      decorationColor: PURPLE,
                      decorationThickness: 1.5,
            )),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          // block scroll,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin:
                  EdgeInsets.only(top: context.mediaQuery.size.width * 0.01),
              child: Column(
                // align right
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAvatarWidget(
                          imageUrl:
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg'),
                      SizedBox(
                          width: context.mediaQuery.size.width *
                              RATIO_PADDING /
                              2),
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
                              MediaQuery.of(context).size.width *
                                  RATIO_PADDING),
                          child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  ',
                              style: context.textTheme.titleSmall),
                        ),
                      ),
                    ],
                  ),
                  const Row(children: [
                    Spacer(),
                    Text(
                      'Reply  ',
                      style: bodySmall,
                    ),
                    Icon(Icons.lens, size: 5, color: BLACK),
                    Text(
                      '  Solve',
                      style: bodySmall,
                    ),
                  ]),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
