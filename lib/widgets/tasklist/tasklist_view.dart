import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/task/task.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';
import 'package:task_managing_application/widgets/custom_item_widget/custom_item_widget.dart';
import 'package:task_managing_application/widgets/custom_tag/project_tag.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';

part 'date.dart';
part 'mini_nav.dart';
part 'progress.dart';
part 'subtask.dart';
part 'list_tag.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key, required this.imageUrl, required this.task});

  final String imageUrl;
  final Task task;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(context.mediaQuery.size.width * RATIO_PADDING),
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
                      width: context.mediaQuery.size.width * RATIO_PADDING),
                  CustomAvatarWidget(imageUrl: imageUrl),
                ],
              ),
              MiniNav()
            ],
          ),
          SizedBox(height: context.mediaQuery.size.width * RATIO_PADDING),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assignee",
                    style: context.textTheme.titleSmall,
                  ),
                  Row(
                    children: [
                      CustomAvatarWidget(
                        imageUrl:
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
                        size: context.mediaQuery.size.width *
                            (RATIO_MARGIN + 0.01),
                      ),
                      SizedBox(
                          width: context.mediaQuery.size.width * 0.01),
                      CustomAvatarWidget(
                        imageUrl:
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
                        size: context.mediaQuery.size.width *
                            (RATIO_MARGIN + 0.01),
                      ),
                      SizedBox(
                          width: context.mediaQuery.size.width * 0.01),
                      CustomAvatarWidget(
                        imageUrl:
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
                        size: context.mediaQuery.size.width *
                            (RATIO_MARGIN + 0.01),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "Completed",
                style: context.textTheme.titleSmall,
              )
            ],
          ),
          SizedBox(height: context.mediaQuery.size.width * RATIO_PADDING),
          ListTag(),
          SizedBox(height: context.mediaQuery.size.width * RATIO_PADDING),
          Date(),
          SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
          Progress(),
          SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
          //  ListView.builder(
          //           scrollDirection: Axis.horizontal,
          //           itemCount: 3,
          //           itemBuilder: (context, index) => SubTask()
          //           ),
          SubTask(),
        ],
      ),
    );
  }
}
