import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/states/states.dart';

import 'project_tag.dart';

class ProjectTagsScrollView extends StatelessWidget {
  const ProjectTagsScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.mediaQuery.size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                state as ProjectUserSubscription;
                return ProjectTagButton(
                  title: const Text("I'm leader"),
                  amount: state.leaderProjectsNumber!,
                  onTap: (context) => context.read<ProjectBloc>().add(
                        state.filterStatus != FilterStatus.leader
                            ? const ProjectFilterEvent(
                                FilterStatus.leader,
                              )
                            : const ProjectFilterEvent(
                                FilterStatus.none,
                              ),
                      ),
                  isSelected: state.filterStatus == FilterStatus.leader,
                  suffixBackgroundColor: context.colorScheme.primary,
                );
              },
            ),
            SizedBox(
              width: context.mediaQuery.size.width * RATIO_MARGIN * 0.6,
            ),
            BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                state as ProjectUserSubscription;
                return ProjectTagButton(
                  title: const Text("On going"),
                  amount: state.onGoingProjectsNumber!,
                  onTap: (context) => context.read<ProjectBloc>().add(
                        state.filterStatus != FilterStatus.ongoing
                            ? const ProjectFilterEvent(
                                FilterStatus.ongoing,
                              )
                            : const ProjectFilterEvent(
                                FilterStatus.none,
                              ),
                      ),
                  isSelected: state.filterStatus == FilterStatus.ongoing,
                  suffixBackgroundColor: context.colorScheme.tertiary,
                );
              },
            ),
            SizedBox(
              width: context.mediaQuery.size.width * RATIO_MARGIN * 0.6,
            ),
            BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                state as ProjectUserSubscription;
                return ProjectTagButton(
                  title: const Text("Completed"),
                  amount: state.completedProjectsNumber!,
                  onTap: (context) => context.read<ProjectBloc>().add(
                        state.filterStatus != FilterStatus.completed
                            ? const ProjectFilterEvent(
                                FilterStatus.completed,
                              )
                            : const ProjectFilterEvent(
                                FilterStatus.none,
                              ),
                      ),
                  isSelected: state.filterStatus == FilterStatus.completed,
                  suffixBackgroundColor: context.colorScheme.secondary,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
