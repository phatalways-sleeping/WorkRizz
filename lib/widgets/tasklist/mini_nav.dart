part of 'tasklist_view.dart';

class MiniNav extends StatelessWidget {
  const MiniNav({
    super.key,
    required this.totalFiles,
    required this.projectName,
    required this.threadId,
  });

  final int totalFiles;
  final String projectName;
  final String threadId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        SvgPicture.string(
          SvgAssets.note,
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
          child: SvgPicture.string(
            SvgAssets.chat,
          ),
        ),
        const EditProjectButton(),
        if (context.watch<TasklistBloc>().state
            is! TasklistSubscriptionEditable) ...[
          const SizedBox(
            width: 10.0,
          ),
          OtherOptionsButton(
            projectId:
                (context.read<TasklistBloc>().state as TasklistSubscription)
                    .project!
                    .id,
          )
        ] else
          const DeleteProjectButton(),
      ],
    );
  }
}
