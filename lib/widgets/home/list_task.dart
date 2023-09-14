import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_dialog.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';
import 'package:task_managing_application/assets/assets.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  double width = 0.0;
  double height = 0.0;
  ScrollController? scrollController;
  TextEditingController controller = TextEditingController();

  // var ActivityManagement = ActivityManagement();
  // List<ActivityStructure> Activity = [];
  @override
  void initState() {
    // Activity = ActivityManagement.getActivitys();
    scrollController = ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }

  // ignore: non_constant_identifier_names
  Widget CategoryScroll(int index, BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    Color color = PINK;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: width * RATIO_PADDING),
            child: Row(
              children: [
                TaskTag(color: color, name: "$index"),
                SizedBox(width: width * RATIO_PADDING),
                Text("Activity $index", style: context.textTheme.titleSmall),
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
            return ActivityScroll(index, context, color);
          },
        ),
        SizedBox(height: width * RATIO_SPACE * 2),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget ActivityScroll(int index, BuildContext context, Color color) {
    // bool newProject = false;
    // if (index == 0 || Activity[index].originProject != Activity[index - 1].originProject)
    //   newProject = true;
    // else
    //   newProject = false;
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: ActivityWidget(index, context, false),
    );
  }

  // ignore: non_constant_identifier_names
  Container ActivityWidget(int index, BuildContext context, bool isDone) {
    return Container(
      margin: EdgeInsets.only(
        left: width * RATIO_PADDING,
        right: width * RATIO_PADDING,
        top: width * RATIO_PADDING,
      ),
      decoration: BoxDecoration(
        color: WHITE,
        borderRadius: BorderRadius.circular(MEDIUM_CORNER),
        border: Border.all(color: BLACK, width: 1),
      ),
      padding: EdgeInsets.all(width * RATIO_PADDING),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'task $index ',
            style: context.textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /* SvgPicture.string(
                SvgAssets.Activity,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ), */
              SizedBox(
                width: width * RATIO_SPACE,
              ),

              //const Spacer(),
              CheckboxWidget(
                  onChanged: (isDone, context) {}, checkState: isDone),
              SizedBox(
                width: width * RATIO_SPACE,
              ),
              Text(
                "xx pt",
                style: context.textTheme.labelMedium,
              ),
              SizedBox(
                width: width * RATIO_SPACE / 2,
              ),
              const Icon(Icons.lens, size: 5, color: BLACK),
              SizedBox(
                width: width * RATIO_SPACE / 2,
              ),
              Text(
                "xx days left",
                style: context.textTheme.labelMedium,
              ),
              SizedBox(
                width: width * RATIO_SPACE,
              ),
              // Text(
              //     '${-Activity[index].date.difference(DateTime.now()).inMinutes} min ago',
              //     style: context.textTheme.bodyMedium),
            ],
          ),
        ],
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
