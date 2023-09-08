import 'package:flutter/material.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_create_bloc/subtask_create_bloc.dart';
import 'package:task_managing_application/widgets/subtask_view/subtask_create/subtask_create.dart';

class SubTaskCreateScreen extends StatefulWidget {
  const SubTaskCreateScreen({Key? key}) : super(key: key);

  @override
  State<SubTaskCreateScreen> createState() => _SubTaskCreateScreenState();
}

class _SubTaskCreateScreenState extends State<SubTaskCreateScreen> {
  @override
  void initState() {
    context.read<SubtaskCreateBloc>().add(
          const SubTaskCreateSubscribeToTaskEvent(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SubTaskCreateView());
  }
}
