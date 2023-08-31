import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/models/task/task_data.dart';
import 'package:task_managing_application/widgets/tasklist/tasklist_view.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TaskListView(ava: Icon(Icons.person), task: instance1)
    );
  }
}

