import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/assets/extensions/build_context_extensions.dart';
import 'package:task_managing_application/assets/models/task/task_data.dart';
import 'package:task_managing_application/assets/svgs/svg_assets.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/tasklist/tasklist_view.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TaskListView(imageUrl:
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg', task: instance1);
  }
}
