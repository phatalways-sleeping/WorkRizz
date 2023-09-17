import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';
import 'package:task_managing_application/widgets/project/project_create/date_input.dart';
import 'package:task_managing_application/widgets/project/project_create/members_adder.dart';
import 'package:task_managing_application/widgets/project/project_create/name_input.dart';
import 'package:task_managing_application/widgets/project/project_create/tags_adder.dart';

class ProjectCreateWidget extends StatefulWidget {
  const ProjectCreateWidget({super.key});

  @override
  State<ProjectCreateWidget> createState() => _ProjectCreateWidgetState();
}

class _ProjectCreateWidgetState extends State<ProjectCreateWidget>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      animationBehavior: AnimationBehavior.preserve);

  late final Animation<double> _animation =
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate);

  @override
  void initState() {
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: _animation,
      child: Container(
        width: context.mediaQuery.size.width,
        height: context.mediaQuery.size.height * 0.50,
        padding: EdgeInsets.symmetric(
          horizontal: context.mediaQuery.size.width * RATIO_PADDING,
          vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.5,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: context.colorScheme.onPrimary,
          shape: const RoundedRectangleBorder(
            side: BorderSide(width: 1.50),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: context.mediaQuery.size.width * 0.3,
                height: 4.0,
                decoration: ShapeDecoration(
                  color: context.colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_PADDING * 0.5,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DefaultTextStyle.merge(
                  style: context.textTheme.displayMedium,
                  child: Text(
                    'Create new project',
                    style: TextStyle(
                      color: context.colorScheme.onSecondary,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => context
                      .read<ProjectBloc>()
                      .add(ProjectRetrieveLatestSetup(context)),
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      CircleBorder(),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.black,
                    ),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.zero,
                    ),
                    minimumSize: MaterialStatePropertyAll(
                      Size(
                        35.0,
                        35.0,
                      ),
                    ),
                    maximumSize: MaterialStatePropertyAll(
                      Size(
                        35.0,
                        35.0,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  child: const Icon(
                    Icons.format_paint_rounded,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _animationController.reverse();
                    await Future.delayed(
                      const Duration(
                        seconds: 2,
                        milliseconds: 500,
                      ),
                    ).then(
                      (value) => context.read<ProjectBloc>().add(
                            const ProjectRequestCloseNewOne(),
                          ),
                    );
                  },
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      CircleBorder(),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.black,
                    ),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.zero,
                    ),
                    minimumSize: MaterialStatePropertyAll(
                      Size(
                        35.0,
                        35.0,
                      ),
                    ),
                    maximumSize: MaterialStatePropertyAll(
                      Size(
                        35.0,
                        35.0,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_PADDING * 0.5,
            ),
            const NameInput(),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_PADDING * 0.5,
            ),
            const TagsAdder(),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_PADDING * 0.5,
            ),
            BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                if (state is ProjectUserSubscription &&
                    state is! ProjectUserCreateAndSubscribe) {
                  return const SizedBox.shrink();
                }
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DateInputWidget(
                      text: "Start date",
                      execute: (context, input) => context
                          .read<ProjectBloc>()
                          .add(ProjectInputStartDate(input)),
                    ),
                    const Spacer(),
                    DateInputWidget(
                      key: const Key('end_date'),
                      startFrom: (state as ProjectUserCreateAndSubscribe)
                          .newProjectSetup
                          .startDate,
                      text: "End date",
                      execute: (context, input) => context
                          .read<ProjectBloc>()
                          .add(ProjectInputEndDate(input)),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_PADDING * 0.5,
            ),
            const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MembersAdder(
                  role: MemberRole.common,
                ),
                Spacer(),
                MembersAdder(
                  role: MemberRole.leader,
                )
              ],
            ),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_PADDING * 0.5,
            ),
            BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                if (state is ProjectUserCreateAndSubscribeLoading) {
                  return CustomCircularProgressIndicator(
                    color: context.colorScheme.primary,
                    size: 25.0,
                  );
                }
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () => context.read<ProjectBloc>().add(
                          ProjectRequestToCreate(context),
                        ),
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(
                          vertical: context.mediaQuery.size.height *
                              RATIO_MARGIN *
                              0.2,
                        ),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        Colors.black,
                      ),
                      overlayColor: MaterialStatePropertyAll(
                        context.colorScheme.primary,
                      ),
                      alignment: Alignment.center,
                      minimumSize: MaterialStatePropertyAll(
                        Size(
                          context.mediaQuery.size.width * 0.9,
                          context.mediaQuery.size.height * 0.02,
                        ),
                      ),
                      maximumSize: MaterialStatePropertyAll(
                        Size(
                          context.mediaQuery.size.width * 0.9,
                          context.mediaQuery.size.height * 0.05,
                        ),
                      ),
                    ),
                    child: DefaultTextStyle.merge(
                      style: context.textTheme.bodyLarge,
                      child: const Text(
                        'Done',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
