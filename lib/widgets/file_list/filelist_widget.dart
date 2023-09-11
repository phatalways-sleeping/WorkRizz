import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_managing_application/models/project/files_small_info.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/file_list/file_widget.dart';

class FileListWidget extends StatelessWidget {
  const FileListWidget({
    super.key,
    required this.files,
  });

  final List<FilesSmallInformation> files;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: files.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TaskTag(
                  color: COLOR_WHEEL[Random().nextInt(
                    COLOR_WHEEL.length,
                  )],
                  name: "${index + 1}",
                ),
                SizedBox(
                  width: context.mediaQuery.size.width * RATIO_PADDING,
                ),
                Text(
                  files[index].taskName,
                  style: context.textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(height: context.mediaQuery.size.width * 0.03),
            ListView.separated(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: files[index].files.length,
              itemBuilder: (BuildContext context, int indexFiles) {
                return FileWidget(
                  fileName: files[index].files[indexFiles].fileName,
                  ownerImageUrl: files[index].files[indexFiles].ownerImageUrl,
                  color: COLOR_WHEEL[Random().nextInt(
                    COLOR_WHEEL.length,
                  )],
                  index: indexFiles,
                  date: files[index].files[indexFiles].uploadDate,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: context.mediaQuery.size.width * RATIO_PADDING,
                );
              },
            ),
            SizedBox(
              height: context.mediaQuery.size.width * RATIO_SPACE * 2,
            ),
          ],
        );
      },
    );
  }
}
