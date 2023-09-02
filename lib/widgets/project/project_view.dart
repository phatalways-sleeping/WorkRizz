import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
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
        return BaseScreen(
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
                  left: context.mediaQuery.size.width * RATIO_PADDING + 5.0,
                  top: 10.0,
                ),
                sliver: const SliverToBoxAdapter(
                  child: ProjectTagsScrollView(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
