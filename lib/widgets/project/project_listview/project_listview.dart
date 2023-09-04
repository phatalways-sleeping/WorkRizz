import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/project/project_listview/project_item.dart';
import 'package:task_managing_application/widgets/project/project_listview/project_item_bloc/project_item_bloc.dart';

class ProjectListView extends StatefulWidget {
  const ProjectListView({super.key});

  @override
  State<ProjectListView> createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: context.mediaQuery.size.height * RATIO_MARGIN * 0.4,
      ),
      itemBuilder: (context, index) => BlocProvider(
        create: (context) => ProjectItemBloc(
          context.read<ProjectBloc>().projectStream,
          context.read<ProjectBloc>().userId,
          context.read<ProjectBloc>().imageFuture,
        ),
        child: ProjectItemWidget(
          projectId: context.watch<ProjectBloc>().state.projects![index],
        ),
      ),
      itemCount: context.watch<ProjectBloc>().state.projects!.length,
    );
  }
}
