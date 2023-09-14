import 'package:flutter/material.dart';
import 'package:task_managing_application/models/sub_task/sub_task_model.dart';
import 'package:task_managing_application/states/home_bloc/home_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/home/project_info_widget.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_box.dart';

class ActivityWidget extends StatefulWidget {
  const ActivityWidget({
    super.key,
    required this.subTaskIds,
  });

  final List<String> subTaskIds;

  @override
  State<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  ScrollController? scrollController;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<HomeBloc>().subTasksForEachProject(),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return ListView.separated(
            controller: scrollController,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) => ShimmerBox(
              width: context.mediaQuery.size.width * 0.9,
              height: context.mediaQuery.size.height * 0.1,
              radius: MEDIUM_CORNER,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10.0,
            ),
            itemCount: 4,
          );
        }

        final Map<String, List<Stream<SubTaskModel>>> subTasksForEachProject =
            snapshot.data as Map<String, List<Stream<SubTaskModel>>>;

        return ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: subTasksForEachProject.length,
          itemBuilder: (BuildContext context, int index) {
            final projectIds = subTasksForEachProject.keys.toList();
            projectIds.sort((a, b) => a.compareTo(b));
            final List<Stream<SubTaskModel>> subTasks =
                subTasksForEachProject[projectIds[index]]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProjectInfoWidget(
                  projectId: projectIds[index],
                ),
                ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: subTasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StreamBuilder(
                        stream: subTasks[index],
                        builder: (context, snapshot) {
                          if (snapshot.hasError || !snapshot.hasData) {
                            return const SizedBox.shrink();
                          }
                          final SubTaskModel subTask =
                              snapshot.data as SubTaskModel;
                          if (subTask.isCompleted) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: EdgeInsets.only(
                              left:
                                  context.mediaQuery.size.width * RATIO_PADDING,
                              right:
                                  context.mediaQuery.size.width * RATIO_PADDING,
                              top:
                                  context.mediaQuery.size.width * RATIO_PADDING,
                            ),
                            child: ElevatedButton(
                              onPressed: () =>
                                  context.read<NavigationBloc>().add(
                                        NavigateToSubTaskDetailFromHome(
                                          subTask.id,
                                        ),
                                      ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.all(context.mediaQuery.size.width *
                                      RATIO_PADDING),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(WHITE),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(MEDIUM_CORNER),
                                  ),
                                ),
                                side: const MaterialStatePropertyAll(
                                  BorderSide(color: BLACK, width: 1),
                                ),
                                alignment: Alignment.centerLeft,
                                overlayColor: const MaterialStatePropertyAll(
                                  GREEN,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    subTask.name,
                                    style: context.textTheme.titleMedium,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: context.mediaQuery.size.width *
                                            RATIO_SPACE,
                                      ),
                                      CheckboxWidget(
                                        onChanged: (isDone, context) =>
                                            context.read<HomeBloc>().add(
                                                  HomeMarkSubTaskCompleteEvent(
                                                    subTaskId: subTask.id,
                                                  ),
                                                ),
                                        checkState: subTask.isCompleted,
                                      ),
                                      SizedBox(
                                        width: context.mediaQuery.size.width *
                                            RATIO_SPACE,
                                      ),
                                      Text(
                                        '${subTask.points}pt',
                                        style: context.textTheme.labelMedium
                                            ?.copyWith(
                                          color: BLACK,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: context.mediaQuery.size.width *
                                            RATIO_SPACE /
                                            2,
                                      ),
                                      const Icon(Icons.lens,
                                          size: 5, color: BLACK),
                                      SizedBox(
                                        width: context.mediaQuery.size.width *
                                            RATIO_SPACE /
                                            2,
                                      ),
                                      Text(
                                        "${subTask.dueDate.difference(
                                              DateTime.now(),
                                            ).inDays} days left",
                                        style: context.textTheme.labelMedium
                                            ?.copyWith(
                                          color: BLACK,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: context.mediaQuery.size.width *
                                            RATIO_SPACE,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
                SizedBox(
                  height: context.mediaQuery.size.width * RATIO_SPACE * 2,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
