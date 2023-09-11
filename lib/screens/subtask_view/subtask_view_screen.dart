import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_view_bloc/subtask_view_bloc.dart';
import 'package:task_managing_application/widgets/subtask_view/subtask_view.dart';

class SubTaskScreen extends StatefulWidget {
  const SubTaskScreen({Key? key}) : super(key: key);

  @override
  State<SubTaskScreen> createState() => _SubTaskScreenState();
}

class _SubTaskScreenState extends State<SubTaskScreen> {
  @override
  void initState() {
    context.read<SubtaskViewBloc>().add(const SubTaskSubscribeEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onPrimary,
      body: SubTaskView(
        isLeader: context.read<SubtaskViewBloc>().isLeader,
      ),
    );
  }
}
