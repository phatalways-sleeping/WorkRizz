part of 'homepage_view.dart';

class MiniNav extends StatelessWidget {
  const MiniNav({
    super.key,
    required this.totalFiles,
    required this.totalNotes,
    required this.totalUnreadMessages,
  });

  final int totalFiles;
  final int totalNotes;
  final int totalUnreadMessages;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Badge(
          backgroundColor: ORANGE,
          label: Text(
            totalFiles.toString(),
            style: context.textTheme.bodySmall,
          ),
          child: SvgPicture.string(
            SvgAssets.file,
          ),
        ),
        SizedBox(
          width: context.mediaQuery.size.width * RATIO_PADDING * 2,
        ),
        Badge(
          backgroundColor: GREEN,
          label: Text(
            totalNotes.toString(),
            style: context.textTheme.bodySmall,
          ),
          child: SvgPicture.string(
            SvgAssets.note,
          ),
        ),
        SizedBox(
          width: context.mediaQuery.size.width * RATIO_PADDING * 2,
        ),
        Badge(
          backgroundColor: PURPLE,
          label: Text(
            totalUnreadMessages.toString(),
            style: context.textTheme.bodySmall,
          ),
          child: SvgPicture.string(
            SvgAssets.chat,
          ),
        ),
        SizedBox(
          width: context.mediaQuery.size.width * RATIO_PADDING * 2,
        ),
        SvgPicture.string(
          SvgAssets.tdot,
        )
      ],
    );
  }
}
