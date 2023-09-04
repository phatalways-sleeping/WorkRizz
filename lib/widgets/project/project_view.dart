import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/project/project_create/project_create_widget.dart';
import 'package:task_managing_application/widgets/project/project_listview/project_listview.dart';
import 'package:task_managing_application/widgets/project/project_tags_scrollview.dart';
import 'package:task_managing_application/widgets/widgets.dart'
    show CustomCircularProgressIndicator;

class ProjectView extends StatefulWidget {
  const ProjectView({super.key});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  late final ScrollController _scrollController = ScrollController()
    ..addListener(() {});

  get separatorBuilder => null;

  get amount => null;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state is ProjectInitial) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        }
        if (state is ProjectError) {
          return ErrorWidget.withDetails(
            message: "An error has occured when trying to fetch your data",
          );
        }
        return Stack(
          children: [
            BaseScreen(
              hideNavigationBar: false,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: CustomHeaderBar(
                      upperChild: Text("Hello ${state.username}"),
                      bottomChild: Text(
                          "Today's ${convertWeekdayToString(DateTime.now().weekday)}"),
                      onPressed: (context) {},
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: context.mediaQuery.size.height * RATIO_PADDING * 0.8,
                    ),
                    sliver: const SliverToBoxAdapter(
                      child: ProjectTagsScrollView(),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          context.mediaQuery.size.width * RATIO_PADDING + 5.0,
                      vertical:
                          context.mediaQuery.size.width * RATIO_PADDING * 2.0,
                    ),
                    sliver: const ProjectListView(),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: BlocConsumer<ProjectBloc, ProjectState>(
                listener: (context, state) {
                  if (state is ProjectUserCreateAndSubscribeClose) {
                    context
                        .read<ProjectBloc>()
                        .add(const ProjectCloseCreateNewOne());
                  }
                },
                builder: (context, state) {
                  if (state is ProjectInitial || state is ProjectError) {
                    return const SizedBox.shrink();
                  }
                  if (state is ProjectUserSubscription &&
                      state is! ProjectUserCreateAndSubscribe) {
                    return const SizedBox.shrink();
                  }
                  return const ProjectCreateWidget();
                },
              ),
            )
          ],
        );
      },
    );
  }
}
