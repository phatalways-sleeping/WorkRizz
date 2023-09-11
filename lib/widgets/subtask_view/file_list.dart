part of 'subtask_view.dart';

class FileList extends StatelessWidget {
  const FileList({
    super.key,
    required this.isAssigned,
    required this.isLeader,
    required this.files,
  });
  final bool isAssigned;
  final bool isLeader;
  final List<String> files;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'File',
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 16.0,
              ),
            ),
            if (context.watch<SubtaskViewBloc>().state
                is SubTaskViewSuccessPendingToUpdateFiles) ...[
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                height: 15.0,
                width: 15.0,
                child: CustomCircularProgressIndicator(
                  color: context.colorScheme.primary,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: SizedBox(
                  width: context.mediaQuery.size.width * 0.5,
                  child: DefaultTextStyle.merge(
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 13.0,
                    ),
                    child: const Text(
                      'Please wait, updating files is in progress',
                    ),
                  ),
                ),
              ),
            ],
            if (isLeader || isAssigned) ...[
              const Spacer(),
              InkWell(
                onTap: () => context.read<SubtaskViewBloc>().add(
                      const SubTaskInputAttachmentEvent(),
                    ),
                child: SvgPicture.string(
                  SvgAssets.upload,
                ),
              ),
            ]
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: files.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                top: context.mediaQuery.size.width * 0.01,
              ),
              child: InkWell(
                onTap: () => context.read<SubtaskViewBloc>().add(
                      SubTaskDownloadAttachmentEvent(
                        'files/${files[index]}',
                      ),
                    ),
                child: Row(
                  children: [
                    SvgPicture.string(
                      SvgAssets.file,
                      colorFilter:
                          const ColorFilter.mode(GREEN, BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: context.mediaQuery.size.width * RATIO_PADDING,
                    ),
                    // underlined text
                    Text(
                      files[index].split('/').last,
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
                    const Spacer(),
                    IconButton.filled(
                      color: context.colorScheme.error,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      splashColor: context.colorScheme.error.withOpacity(0.2),
                      splashRadius: 10.0,
                      onPressed: () => context.read<SubtaskViewBloc>().add(
                            SubTaskDeleteAttachmentEvent(
                              'files/${files[index]}',
                            ),
                          ),
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
