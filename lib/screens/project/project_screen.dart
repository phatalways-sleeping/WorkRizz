import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/widgets.dart'
    show ProjectView;

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProjectView(),
    );
  }
}
