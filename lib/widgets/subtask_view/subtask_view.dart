import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/assets/fonts/base_font.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';
import 'package:task_managing_application/widgets/project/project_create/date_input.dart';
import 'package:task_managing_application/widgets/project/project_create/members_adder.dart';
import 'package:task_managing_application/widgets/subtask_view/input/description_input.dart';
import 'package:task_managing_application/widgets/subtask_view/input/duedate_input.dart';
import 'package:task_managing_application/widgets/subtask_view/input/review_score_input.dart';
import 'package:task_managing_application/widgets/subtask_view/input/score_input.dart';

part 'comment_list.dart';
part 'file_list.dart';
part 'review.dart';

// ignore: must_be_immutable
class SubTaskView extends StatefulWidget {
  SubTaskView({super.key, required this.isLeader, required this.isAssigned});
  Function()? changeColor;
  final bool isLeader;
  final bool isAssigned;

  @override
  State<SubTaskView> createState() => _SubTaskViewState();
}

class _SubTaskViewState extends State<SubTaskView> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: CustomHeaderBar(
                upperChild: Row(children: [
                  const Icon(Icons.arrow_back_ios_new_outlined,
                      color: BLACK, size: 16.0),
                  SizedBox(
                    width: context.mediaQuery.size.width * RATIO_PADDING,
                  ),
                  Text('Mobile Final', style: context.textTheme.labelMedium),
                ]),
                bottomChild: Row(
                  children: [
                    CheckboxWidget(
                      checkState: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    const Text("Design UI"),
                  ],
                ),
                onPressed: (context) {}),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.mediaQuery.size.width * RATIO_PADDING + 5.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('By', style: context.textTheme.titleSmall),
                          SizedBox(
                              width: context.mediaQuery.size.width *
                                  RATIO_PADDING),
                          const CustomAvatarWidget(
                              imageUrl:
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg'),
                        ],
                      ),
                      SvgPicture.string(SvgAssets.tdot)
                    ],
                  ),
                  SizedBox(
                      height: context.mediaQuery.size.width * RATIO_PADDING),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Due Date',
                              style: context.textTheme.labelMedium),
                          widget.isLeader
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          0.01 * context.mediaQuery.size.width,
                                    ),
                                    DueDateInputWidget(
                                        execute:
                                            (BuildContext t, DateTime m) {}),
                                  ],
                                )
                              : Container(
                                  width: context.mediaQuery.size.width * 0.4,
                                  margin: EdgeInsets.only(
                                      top:
                                          context.mediaQuery.size.width * 0.01),
                                  decoration: BoxDecoration(
                                    // border black, size 1, round corner 12
                                    border: Border.all(
                                      color: BLACK,
                                      width: BORDER_WIDTH,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(MEDIUM_CORNER),
                                  ),
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width *
                                          RATIO_PADDING),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.date_range_rounded,
                                          color: PALE),
                                      SizedBox(
                                          width: context.mediaQuery.size.width *
                                              RATIO_PADDING),
                                      Text('Sep 5th 2023',
                                          style: context.textTheme.titleSmall),
                                    ],
                                  )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Points', style: context.textTheme.labelMedium),
                          widget.isLeader
                              ? Container(
                                  margin: EdgeInsets.only(
                                      top:
                                          context.mediaQuery.size.width * 0.01),
                                  width: context.mediaQuery.size.width * 0.4,
                                  child: const ScoreInput())
                              : Container(
                                  width: context.mediaQuery.size.width * 0.4,
                                  margin: EdgeInsets.only(
                                      top:
                                          context.mediaQuery.size.width * 0.01),
                                  decoration: BoxDecoration(
                                    // border black, size 1, round corner 12
                                    border: Border.all(
                                      color: BLACK,
                                      width: BORDER_WIDTH,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(MEDIUM_CORNER),
                                  ),
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width *
                                          RATIO_PADDING),
                                  child: Row(
                                    children: [
                                      SvgPicture.string(
                                        SvgAssets.note,
                                        colorFilter: const ColorFilter.mode(
                                            PINK, BlendMode.srcIn),
                                      ),
                                      SizedBox(
                                          width: context.mediaQuery.size.width *
                                              RATIO_PADDING),
                                      Text('10pt',
                                          style: context.textTheme.titleSmall),
                                    ],
                                  )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description', style: context.textTheme.labelMedium),
                      widget.isLeader
                          ? Column(
                              children: [
                                SizedBox(
                                    height:
                                        context.mediaQuery.size.width * 0.01),
                                const DescriptionInput(
                                  label: 'Description',
                                  showLabel: false,
                                ),
                              ],
                            )
                          : Container(
                              // width: max available width, finite
                              width: double.maxFinite,
                              height: context.mediaQuery.size.height * 0.1,
                              margin: EdgeInsets.only(
                                  top: context.mediaQuery.size.width * 0.01),
                              decoration: BoxDecoration(
                                // border black, size 1, round corner 12
                                border: Border.all(
                                  color: BLACK,
                                  width: BORDER_WIDTH,
                                ),
                                borderRadius:
                                    BorderRadius.circular(MEDIUM_CORNER),
                              ),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      RATIO_PADDING),
                              child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisl eget nunc aliquam aliquet.',
                                  style: context.textTheme.titleSmall),
                            ),
                    ],
                  ),
                  SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
                  File(isAssigned: widget.isAssigned),
                  SizedBox(
                      height: context.mediaQuery.size.width * RATIO_PADDING),
                  Comment(
                    isAssigned: widget.isAssigned,
                  ),
                  const SizedBox(),
                  Review(
                    isAssigned: widget.isLeader,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
