part of 'subtask_view.dart';

class FileList extends StatelessWidget {
  const FileList({super.key, required this.isAssigned});
  final bool isAssigned;

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
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        SvgPicture.string(
                          SvgAssets.file,
                          colorFilter:
                              const ColorFilter.mode(GREEN, BlendMode.srcIn),
                        ),
                        SizedBox(
                            width:
                                context.mediaQuery.size.width * RATIO_PADDING),
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
                  ),
                );
              },
            ),
          ],
        ),
        Positioned(
            right: 0,
            top: 0,
            child: InkWell(
                onTap: () {
                  if (isAssigned) {}
                },
                child: SvgPicture.string(SvgAssets.upload)))
      ],
    );
  }
}
