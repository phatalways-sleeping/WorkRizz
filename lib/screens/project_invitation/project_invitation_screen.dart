import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/user_project_invitation/user_project_invitation_bloc.dart';
import 'package:task_managing_application/widgets/project_invitation/project_invitation_view.dart';

class ProjectInvitationScreen extends StatefulWidget {
  const ProjectInvitationScreen({super.key});

  @override
  State<ProjectInvitationScreen> createState() => _ProjectInvitationScreenState();
}

class _ProjectInvitationScreenState extends State<ProjectInvitationScreen> {
  @override
  void initState() {
    context.read<UserProjectInvitationBloc>().add(
          const UserProjectInvitationSubscribeToStream(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ProjectInvitationsView(),
      backgroundColor: context.colorScheme.onPrimary,
    );
  }
}
