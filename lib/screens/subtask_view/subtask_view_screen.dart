import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/subtask_view/subtask_view.dart';

class SubTaskScreen extends StatelessWidget {
  const SubTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SubTaskView(isLeader: true, isAssigned: false,)
    );
  }
}

