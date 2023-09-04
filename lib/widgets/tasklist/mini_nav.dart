part of 'tasklist_view.dart';

class MiniNav extends StatelessWidget {
  const MiniNav({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Badge(
            backgroundColor: ORANGE,
            label: Text(
              '1',
              style: context.textTheme.bodySmall,
            ),
            child: SvgPicture.string(SvgAssets.file)),
        SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING * 2),
        Badge(
            backgroundColor: GREEN,
            label: Text(
              '1',
              style: context.textTheme.bodySmall,
            ),
            child: SvgPicture.string(SvgAssets.note)),
        SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING * 2),
        Badge(
            backgroundColor: PURPLE,
            label: Text(
              '1',
              style: context.textTheme.bodySmall,
            ),
            child: SvgPicture.string(SvgAssets.chat)),
        SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING * 2),
        SvgPicture.string(SvgAssets.tdot)
      ],
    );
  }
}
