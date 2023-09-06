import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';
import 'package:task_managing_application/widgets/subtask_view/input/description_input.dart';
import 'package:task_managing_application/widgets/subtask_view/input/duedate_input.dart';
import 'package:task_managing_application/widgets/subtask_view/input/score_input.dart';
import 'package:task_managing_application/widgets/subtask_view/subtask_create/assignee_adder.dart';
import 'file.dart';

// ignore: must_be_immutable
class SubTaskCreateView extends StatefulWidget {
  final Function()? changeColor;

  const SubTaskCreateView({
    super.key,
    this.changeColor,
  });

  @override
  State<SubTaskCreateView> createState() => _SubTaskCreateViewState();
}

class _SubTaskCreateViewState extends State<SubTaskCreateView> {
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
                bottomChild: const Text("Create New Task"),
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
                          const AssigneeAdder(),
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
                          Column(
                            children: [
                              SizedBox(
                                height: 0.01 * context.mediaQuery.size.width,
                              ),
                              DueDateInputWidget(
                                  execute: (BuildContext t, DateTime m) {}),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Points', style: context.textTheme.labelMedium),
                          Container(
                              margin: EdgeInsets.only(
                                  top: context.mediaQuery.size.width * 0.01),
                              width: context.mediaQuery.size.width * 0.4,
                              child: const ScoreInput())
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Title', style: context.textTheme.labelMedium),
                      SizedBox(height: context.mediaQuery.size.width * 0.01),
                      const DescriptionInput(
                        label: 'Title',
                        showLabel: false,
                      ),
                      SizedBox(
                          height: context.mediaQuery.size.width * RATIO_SPACE),
                      Text('Description', style: context.textTheme.labelMedium),
                      SizedBox(height: context.mediaQuery.size.width * 0.01),
                      const DescriptionInput(
                        label: 'Description',
                        showLabel: false,
                      ),
                      SizedBox(
                          height: context.mediaQuery.size.width * RATIO_SPACE),
                    ],
                  ),
                  CreateFile(),
                  SizedBox(
                      height: context.mediaQuery.size.width * RATIO_PADDING),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(
                          vertical: context.mediaQuery.size.height *
                              RATIO_MARGIN *
                              0.2,
                        ),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        Colors.black,
                      ),
                      overlayColor: MaterialStatePropertyAll(
                        context.colorScheme.primary,
                      ),
                      alignment: Alignment.center,
                      fixedSize: MaterialStatePropertyAll(
                        Size(
                          context.mediaQuery.size.width * 0.9,
                          context.mediaQuery.size.height * 0.05,
                        ),
                      ),
                    ),
                    child: DefaultTextStyle.merge(
                      style: context.textTheme.bodyLarge,
                      child: const Text(
                        'Done',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
