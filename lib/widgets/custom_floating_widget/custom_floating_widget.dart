import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/navigation_bloc/navigation_bloc.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';

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
    return InkWell(
      splashColor: context.colorScheme.error,
      splashFactory: InkRipple.splashFactory,
      borderRadius: BorderRadius.circular(13),
      overlayColor: MaterialStateProperty.resolveWith((states) {
        if (states.isPressed) {
          return context.colorScheme.surface;
        }
        return null;
      }),
      onTap: () {
        if (context.read<NavigationBloc>().state is ProjectsList) {
          if (context.read<ProjectBloc>().state is ProjectUserSubscription) {
            context.read<ProjectBloc>().add(const ProjectCreateNewOne());
          }
        }
      },
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: context.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: SvgPicture.string(
          icon,
          fit: BoxFit.contain,
          colorFilter: const ColorFilter.mode(
            Colors.black,
            BlendMode.srcATop,
          ),
        ),
      ),
    );
  }
}
