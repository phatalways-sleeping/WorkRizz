import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/project/project_listview/project_item_bloc/project_item_bloc.dart';

class ProjectTagWidget extends StatelessWidget {
  const ProjectTagWidget({
    super.key,
    required this.tag,
    required this.color,
  });

  final Tag tag;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectItemBloc, ProjectItemState>(
      builder: (context, state) {
        return Container(
          constraints: BoxConstraints.tightFor(
            height: context.mediaQuery.size.height * 0.03,
          ),
          margin: const EdgeInsets.only(
            right: 5.0,
            top: 5.0,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.mediaQuery.size.width * RATIO_PADDING,
            vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.01,
          ),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            color: (state is ProjectItemSuccess ||
                    (state is ProjectItemSuccessWithFilterStatus &&
                        state.filterColor == Colors.white))
                ? color
                : context.colorScheme.onSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: DefaultTextStyle.merge(
            style: context.textTheme.bodyMedium,
            child: Text(
              tag.title,
              style: TextStyle(
                color: (state is ProjectItemSuccess ||
                        (state is ProjectItemSuccessWithFilterStatus &&
                            state.filterColor == Colors.white))
                    ? context.colorScheme.onSecondary
                    : context.colorScheme.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}
