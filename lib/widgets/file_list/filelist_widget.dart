import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_dialog.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';
import 'file_dbms.dart';
import 'package:task_managing_application/assets/assets.dart';

class FileList extends StatefulWidget {
  const FileList({super.key});

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  double width = 0.0;
  double height = 0.0;
  ScrollController? scrollController;
  TextEditingController controller = TextEditingController();

  var fileManagement = FileManagement();
  List<FileStructure> fileList = [];
  @override
  void initState() {
    fileList = fileManagement.getFiles();
    scrollController = ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }

  Widget CategoryScroll(int index, BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    Color color = COLOR_WHEEL[
        Random().nextInt(COLOR_WHEEL.length)]; /*random a color in color wheel*/
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: width * RATIO_PADDING),
            child: Row(
              children: [
                TaskTag(color: color, name: "$index"),
                SizedBox(width: width * RATIO_PADDING),
                Text("Task $index", style: context.textTheme.titleSmall),
              ],
            )),
        // SizedBox(height: width * RATIO_SPACE),
        ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return FileScroll(index, context, color);
          },
        ),
        SizedBox(height: width * RATIO_SPACE * 2),
      ],
    );
  }

  Widget FileScroll(int index, BuildContext context, Color color) {
    // bool newProject = false;
    // if (index == 0 || fileList[index].originProject != fileList[index - 1].originProject)
    //   newProject = true;
    // else
    //   newProject = false;
    return GestureDetector(
      onTap: () {
        setState(() {
          // download
        });
      },
      child: Container(
        margin: EdgeInsets.only(
          left: width * RATIO_PADDING,
          right: width * RATIO_PADDING,
          top: width * RATIO_PADDING,
        ),
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          background: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                color: BLACK),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 15),
                child: const Icon(Icons.delete, color: WHITE),
              ),
            ),
          ),
          confirmDismiss: (direction) {
            return showDialog(
              context: context,
              builder: (context) => CustomDialog(
                title: "Remove this File",
                leftText: "No",
                rightText: "Yes",
                leftColor: PURPLE,
                rightColor: PINK,
                focusleftColor: PALE,
                focusrightColor: GREEN,
                onLeftPressed: (context) {
                  Navigator.of(context).pop(false);
                },
                onRightPressed: (context) {
                  Navigator.of(context).pop(true);
                },
              ),
            );
          },
          onDismissed: (DismissDirection direction) {
            setState(() {
              fileList.removeAt(index);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: WHITE,
              borderRadius: BorderRadius.circular(MEDIUM_CORNER),
              border: Border.all(color: BLACK, width: 1),
            ),
            padding: EdgeInsets.all(width * RATIO_PADDING),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.string(
                  SvgAssets.file,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                SizedBox(
                  width: width * RATIO_SPACE,
                ),
                Text(
                  '${fileList[index].name}.${fileList[index].type}',
                  style: context.textTheme.titleSmall,
                ),
                const Spacer(),
                const CustomAvatarWidget(
                  imageUrl: 'assets/images/avatars/avatar_1.jpg',
                  size: 20,
                ),
                SizedBox(
                  width: width * RATIO_SPACE,
                ),
                Text(
                    '${-fileList[index].date.difference(DateTime.now()).inMinutes} min ago',
                    style: context.textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return ListView.builder(
      controller: scrollController,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return CategoryScroll(index, context);
      },
    );
  }
}
