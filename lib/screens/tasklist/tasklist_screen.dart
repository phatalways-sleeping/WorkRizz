import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/models/task/task_data.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/tasklist/tasklist_view.dart';
import 'package:task_managing_application/widgets/widgets.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
              const SliverPersistentHeader(
                pinned: true,
                delegate: CustomHeaderBar(
                  username: 'Liana',
                  imageUrl:
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
                ),
              ),
            SliverToBoxAdapter(
              child: TaskListView(ava: Icon(Icons.person), task: instance1),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

