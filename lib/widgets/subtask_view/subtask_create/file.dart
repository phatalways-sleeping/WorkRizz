import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_create_bloc/subtask_create_bloc.dart';

class CreateFile extends StatelessWidget {
  const CreateFile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtaskCreateBloc, SubtaskCreateState>(
      builder: (context, state) {
        if (state is SubtaskCreateInitial ||
            state is SubtaskCreateFailureDueToNetwork ||
            state is SubTaskCreateFailureDueToDataIntegrity) {
          return const SizedBox.shrink();
        }
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
                const Spacer(),
                InkWell(
                  onTap: () async {},
                  child: SvgPicture.string(
                    SvgAssets.upload,
                  ),
                ),
              ],
            ),
            if ((state as SubtaskCreateSuccess).attachments == null ||
                state.attachments!.isEmpty)
              const SizedBox.shrink()
            else
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.attachments!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: context.mediaQuery.size.width * 0.01),
                    child: InkWell(
                      onTap: () => context.read<SubtaskCreateBloc>().add(
                            SubTaskDownloadAttachmentEvent(
                                state.attachments![index]),
                          ),
                      child: Row(
                        children: [
                          SvgPicture.string(
                            SvgAssets.file,
                            colorFilter: const ColorFilter.mode(
                              GREEN,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(
                            width:
                                context.mediaQuery.size.width * RATIO_PADDING,
                          ),
                          // underlined text
                          Text(
                            state.attachments![index].path.split('/').last,
                            style: context.textTheme.bodyMedium?.copyWith(
                              shadows: [
                                const Shadow(
                                    color: BLACK, offset: Offset(0, -3))
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
        );
      },
    );
  }
}
