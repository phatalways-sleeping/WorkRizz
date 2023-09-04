import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/task/task.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';
import 'package:task_managing_application/widgets/custom_item_widget/custom_item_widget.dart';
import 'package:task_managing_application/widgets/custom_tag/project_tag.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';
import 'package:task_managing_application/widgets/tasklist/switch.dart';

part 'date.dart';
part 'mini_nav.dart';
part 'progress.dart';
part 'subtask.dart';
part 'list_tag.dart';
part 'list_subtask.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key, required this.task, required this.imageUrl});

  final String imageUrl;
  final Task task;

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late final ScrollController _scrollController = ScrollController()
    ..addListener(() {});

  get separatorBuilder => null;

  get amount => null;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseScreen(
      hideNavigationBar: true,
      child: CustomScrollView(controller: _scrollController, slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: CustomHeaderBar(
              upperChild: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: BLACK, size: 16.0),
              bottomChild: const Text("Mobile Final"),
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
                        Text('Leader', style: context.textTheme.titleSmall),
                        SizedBox(
                            width:
                                context.mediaQuery.size.width * RATIO_PADDING),
                        CustomAvatarWidget(imageUrl: widget.imageUrl),
                      ],
                    ),
                    const MiniNav()
                  ],
                ),
                SizedBox(height: context.mediaQuery.size.width * RATIO_PADDING),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Assignee",
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      "Completed",
                      style: context.textTheme.titleSmall,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomAvatarWidget(
                          imageUrl:
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
                          size: context.mediaQuery.size.width *
                              (RATIO_MARGIN + 0.01),
                        ),
                        SizedBox(width: context.mediaQuery.size.width * 0.01),
                        CustomAvatarWidget(
                          imageUrl:
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
                          size: context.mediaQuery.size.width *
                              (RATIO_MARGIN + 0.01),
                        ),
                        SizedBox(width: context.mediaQuery.size.width * 0.01),
                        CustomAvatarWidget(
                          imageUrl:
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
                          size: context.mediaQuery.size.width *
                              (RATIO_MARGIN + 0.01),
                        ),
                      ],
                    ),
                    const SwitchButton()
                  ],
                ),
              ],
            ),
          ),
        ),
        const ListTag(),
        SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.mediaQuery.size.width * RATIO_PADDING + 5.0,
            ),
            sliver: SliverToBoxAdapter(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.mediaQuery.size.width * RATIO_PADDING),
                const Date(),
                SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
                const Progress(),
                SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
              ],
            ))),
        const ListSubTask(),
      ]),
    );
  }
}
