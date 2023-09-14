import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/home_bloc/home_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';

class ProjectInfoWidget extends StatefulWidget {
  const ProjectInfoWidget({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  State<ProjectInfoWidget> createState() => _ProjectInfoWidgetState();
}

class _ProjectInfoWidgetState extends State<ProjectInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        context.read<HomeBloc>().projectName(widget.projectId),
        context.read<HomeBloc>().tagCount(widget.projectId),
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final List<dynamic> data = snapshot.data as List<dynamic>;
        final String projectName = data[0] as String;
        final int tagCount = data[1] as int;
        return Container(
          margin: EdgeInsets.only(
            left: context.mediaQuery.size.width * RATIO_PADDING,
          ),
          child: Row(
            children: [
              TaskTag(color: PALE, name: '$tagCount'),
              SizedBox(
                width: context.mediaQuery.size.width * RATIO_PADDING,
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: SizedBox(
                  width: context.mediaQuery.size.width * 0.8,
                  child: Text(
                    projectName,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: BLACK,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
