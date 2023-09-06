import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/navigation_bloc/navigation_bloc.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/states/tasklist_bloc/tasklist_bloc.dart';

class CustomFloatingWidget extends StatelessWidget {
  const CustomFloatingWidget({
    super.key,
    this.size = BOTTOM_NAVIGATION_BAR,
    this.icon = SvgAssets.floatingButtonStar,
  });

  final double size;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom:
            context.read<NavigationBloc>().state is ProjectsList ? 0.0 : 10.0,
      ),
      child: FloatingActionButton(
        onPressed: () {
          if (context.read<NavigationBloc>().state is ProjectsList) {
            if (context.read<ProjectBloc>().state is ProjectUserSubscription) {
              context.read<ProjectBloc>().add(const ProjectCreateNewOne());
            }
          }
          if (context.read<NavigationBloc>().state is TaskList) {
            if (context.read<TasklistBloc>().state is TasklistSubscription) {
              context
                  .read<TasklistBloc>()
                  .add(const TasklistOpenTaskCreateDialog());
            }
          }
        },
        backgroundColor: context.colorScheme.tertiary,
        elevation: 10,
        splashColor: context.colorScheme.secondary,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: SvgPicture.string(
            icon,
            width: size * 0.6,
            height: size * 0.6,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcATop,
            ),
          ),
        ),
      ),
    );
  }
}
