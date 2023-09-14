import 'package:flutter/material.dart';
import 'package:task_managing_application/models/project/files_small_info.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/file_list/file_widget.dart';

// ignore: constant_identifier_names
const Map<String, Color> COLOR_WHEEL2 = {
  ".doc": PURPLE,
  ".docx": PURPLE,
  ".pdf": PALE,
  ".ppt": PALE,
  ".pptx": PALE,
  ".xls": GREEN,
  ".xlsx": GREEN,
  ".zip": PURPLE,
  ".rar": PINK,
  ".txt": ORANGE,
  ".csv": GREEN,
};

Color getColor(String fileName) {
  String s = fileName.substring(fileName.lastIndexOf('.'));
  if (COLOR_WHEEL2.containsKey(s)) {
    return COLOR_WHEEL2[s]!;
  } else {
    return GREY;
  }
}

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
                  color: GREY,
                  name: "${files[index].files.length}",
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
                  color: // return color based on file name extension
                      getColor(files[index].files[indexFiles].fileName),
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
