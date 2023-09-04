part of 'subtask_view.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Review', style: context.textTheme.labelMedium),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('xx%', style: context.textTheme.titleLarge),
                    SizedBox(
                        width: context.mediaQuery.size.width * RATIO_PADDING),
                    Text('Completed', style: context.textTheme.titleSmall),
                  ],
                )),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('xx/xx', style: context.textTheme.titleLarge),
                    SizedBox(
                        width: context.mediaQuery.size.width * RATIO_PADDING),
                    Text('Points', style: context.textTheme.titleSmall),
                  ],
                )),
          ],
        ),
        SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
        Container(
          // width: max available width, finite
          constraints: BoxConstraints(
            minHeight: context.mediaQuery.size.height * 0.1,
          ),
          margin: EdgeInsets.only(top: context.mediaQuery.size.width * 0.01),
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
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisl eget nunc aliquam aliquet.',
              style: context.textTheme.titleSmall),
        )
      ],
    );
  }
}
