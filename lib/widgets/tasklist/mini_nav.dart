part of 'tasklist_view.dart';

class MiniNav extends StatelessWidget {
  const MiniNav({
    super.key,
    required this.totalFiles,
    required this.totalNotes,
    required this.totalUnreadMessages,
    required this.projectName,
    required this.threadId,
  });

  final int totalFiles;
  final int totalNotes;
  final int totalUnreadMessages;
  final String projectName;
  final String threadId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Badge(
          backgroundColor: ORANGE,
          label: Text(
            totalFiles.toString(),
            style: context.textTheme.labelMedium,
          ),
          child: InkWell(
            onTap: () {
              context
                  .read<NavigationBloc>()
                  .add(NavigateToFileList(projectName));
            },
            child: SvgPicture.string(
              SvgAssets.file,
            ),
          ),
        ),
        SizedBox(
          width: context.mediaQuery.size.width * RATIO_PADDING * 2,
        ),
        Badge(
          backgroundColor: GREEN,
          label: Text(
            totalNotes.toString(),
            style: context.textTheme.labelMedium,
          ),
          child: SvgPicture.string(
            SvgAssets.note,
          ),
        ),
        SizedBox(
          width: context.mediaQuery.size.width * RATIO_PADDING * 2,
        ),
        InkWell(
          onTap: () => context.read<NavigationBloc>().add(
                NavigateToMessage(
                  threadId,
                ),
              ),
          child: Badge(
            backgroundColor: PURPLE,
            label: Text(
              totalUnreadMessages.toString(),
              style: context.textTheme.labelMedium,
            ),
            child: SvgPicture.string(
              SvgAssets.chat,
            ),
          ),
        ),
        SizedBox(
          width: context.mediaQuery.size.width * RATIO_PADDING * 2,
        ),
        ExportReportButton(
          projectId:
              (context.read<TasklistBloc>().state as TasklistSubscription)
                  .project!
                  .id,
        ),
      ],
    );
  }
}
