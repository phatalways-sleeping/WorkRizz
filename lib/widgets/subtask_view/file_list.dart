part of 'subtask_view.dart';

class File extends StatelessWidget {
  const File({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('File', style: context.textTheme.labelMedium),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      top: context.mediaQuery.size.width * 0.01),
                  child: Row(
                    children: [
                      SvgPicture.string(
                        SvgAssets.file,
                        colorFilter:
                            const ColorFilter.mode(GREEN, BlendMode.srcIn),
                      ),
                      SizedBox(
                          width: context.mediaQuery.size.width * RATIO_PADDING),
                      // underlined text
                      Text(
                        'File $index',
                        style: context.textTheme.bodyMedium?.copyWith(
                          shadows: [
                            const Shadow(color: BLACK, offset: Offset(0, -3))
                          ],
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: BLACK,
                          decorationThickness: 1.5,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        Positioned(right: 0, top: 0, child: SvgPicture.string(SvgAssets.upload))
      ],
    );
  }
}
