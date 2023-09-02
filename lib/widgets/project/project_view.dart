import 'package:flutter/material.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({super.key});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideAppBar: false,
      hideNavigationBar: false,
      child: CustomScrollView(
        slivers: [],
      ),
    );
  }
}
