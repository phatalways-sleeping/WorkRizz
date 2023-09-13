import 'package:flutter/material.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/tasklist/tasklist_view.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    context.read<TasklistBloc>().add(const TasklistSubscribeToFirestore());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TaskListView(),
    );
  }
}
