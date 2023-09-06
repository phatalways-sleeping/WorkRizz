import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/subtask_view/subtask_create/subtask_create.dart';

class SubTaskCreateScreen extends StatelessWidget {
  const SubTaskCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SubTaskCreateView()
    );
  }
}

