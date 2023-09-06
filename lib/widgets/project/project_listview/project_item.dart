import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/navigation_bloc/navigation_bloc.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/future_avatar_widget.dart';
import 'package:task_managing_application/widgets/project/project_listview/project_item_bloc/project_item_bloc.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_config.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_loading.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_wrapper.dart';
import 'package:task_managing_application/widgets/widgets.dart';

class ProjectItemWidget extends StatefulWidget {
  const ProjectItemWidget({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  State<ProjectItemWidget> createState() => _ProjectItemWidgetState();
}

class _ProjectItemWidgetState extends State<ProjectItemWidget> {
  @override
  void initState() {
    context.read<ProjectItemBloc>().add(
          ProjectItemSubscribeToProjectEvent(widget.projectId),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectItemBloc, ProjectItemState>(
      builder: (context, state) {
        if (state is ProjectItemInitial || state is ProjectItemLoading) {
          return Shimmer(
            linearGradient: shimmer_gradient,
            child: ShimmerLoading(
              child: Container(
                width: context.mediaQuery.size.width * 0.95,
                height: context.mediaQuery.size.height * 0.2,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      25.0,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        if (state is ProjectItemError) {
          return Shimmer(
            linearGradient: shimmer_gradient,
            child: ShimmerLoading(
              child: Container(
                width: context.mediaQuery.size.width * 0.95,
                height: context.mediaQuery.size.height * 0.2,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      25.0,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return BlocListener<ProjectBloc, ProjectState>(
          listenWhen: (previous, current) =>
              (previous as ProjectUserSubscription).filterStatus !=
              (current as ProjectUserSubscription).filterStatus,
          listener: (context, state) {
            if (state is ProjectUserSubscription) {
              context
                  .read<ProjectItemBloc>()
                  .add(ProjectItemFilterEvent(state.filterStatus));
            }
          },
          child: ElevatedButton(
            onPressed: () => context.read<NavigationBloc>().add(
                  NavigateToTask(
                    widget.projectId,
                  ),
                ),
            style: ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal:
                      context.mediaQuery.size.width * RATIO_PADDING,
                  vertical:
                      context.mediaQuery.size.height * RATIO_PADDING * 0.6,
                ),
              ),
              maximumSize: MaterialStatePropertyAll(
                Size(
                  context.mediaQuery.size.width,
                  context.mediaQuery.size.height * 0.2,
                ),
              ),
              backgroundColor: MaterialStatePropertyAll(
                (state is ProjectItemSuccess)
                    ? context.colorScheme.onPrimary
                    : (state as ProjectItemSuccessWithFilterStatus).filterColor,
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(
                    color: context.colorScheme.onSecondary,
                    width: 1.50,
                  ),
                ),
              ),
              elevation: MaterialStateProperty.resolveWith(
                (states) => states.isPressed ? 10.0 : 4.0,
              ),
              overlayColor: MaterialStatePropertyAll(
                context.colorScheme.secondary,
              ),
              splashFactory: InkSparkle.splashFactory,
              animationDuration: const Duration(
                seconds: 2,
              ),
              tapTargetSize: MaterialTapTargetSize.padded,
              iconSize: const MaterialStatePropertyAll(
                25.0,
              ),
              iconColor: MaterialStatePropertyAll(
                context.colorScheme.onSecondary,
              ),
              alignment: Alignment.center,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DefaultTextStyle.merge(
                      style: context.textTheme.bodyLarge,
                      child: BlocSelector<ProjectItemBloc, ProjectItemState,
                          String>(
                        selector: (state) => state.name!,
                        builder: (context, state) {
                          return Text(
                            state,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.more_horiz_rounded,
                      size: 25.0,
                    )
                  ],
                ),
                SizedBox(
                  height: context.mediaQuery.size.height * RATIO_MARGIN * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: state.tagsList,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return SizedBox(
                            width: 25.0,
                            child: Icon(
                              Icons.error,
                              color: context.colorScheme.error,
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: snapshot.data!,
                          );
                        }
                        return const CustomCircularProgressIndicator(
                          size: 25.0,
                        );
                      },
                    ),
                    const Spacer(),
                    FutureBuilder(
                      future: context
                          .read<ProjectItemBloc>()
                          .imageFuture(state.leaderImageUrl!),
                      builder: (context, snaphot) {
                        if (snaphot.hasError) {
                          return CircleAvatar(
                            child: Center(
                              child: Icon(
                                Icons.error,
                                color: context.colorScheme.error,
                                size: 20.0,
                              ),
                            ),
                          );
                        }
                        if (snaphot.hasData) {
                          return FutureAvatarWidget(
                            avatarRatio: 0.06,
                            radiusRatio: 0.04,
                            imageUrl: snaphot.data!,
                            onTap: (context) {},
                          );
                        }
                        return const CustomCircularProgressIndicator(
                          size: 20.0,
                        );
                      },
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.date_range_rounded,
                      size: 25.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    DefaultTextStyle.merge(
                      style: context.textTheme.bodySmall,
                      child: BlocSelector<ProjectItemBloc, ProjectItemState,
                          DateTime?>(
                        selector: (state) => state.endDate!,
                        builder: (context, state) {
                          return Text(
                            "${convertMonthToString(state!.month)} ${state.day}${state.day == 1 ? 'st' : state.day == 2 ? 'nd' : state.day == 3 ? 'rd' : 'th'} ${state.year}",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.link_rounded,
                      size: 25.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    DefaultTextStyle.merge(
                      style: context.textTheme.bodySmall,
                      child:
                          BlocSelector<ProjectItemBloc, ProjectItemState, int>(
                        selector: (state) => state.totalFileLinks!,
                        builder: (context, state) {
                          return Text(
                            state.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.message_rounded,
                      size: 25.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    DefaultTextStyle.merge(
                      style: context.textTheme.bodySmall,
                      child:
                          BlocSelector<ProjectItemBloc, ProjectItemState, int>(
                        selector: (state) => state.totalFileLinks!,
                        builder: (context, state) {
                          return Text(
                            state.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    FutureBuilder(
                      future: context.read<ProjectItemBloc>().assigneeAvatars(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return SizedBox(
                            width: 25.0,
                            child: Icon(
                              Icons.error,
                              color: context.colorScheme.error,
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          return AvatarStack(
                            height: 35.0,
                            width: 75.0,
                            avatars: snapshot.data!,
                          );
                        }
                        return const CustomCircularProgressIndicator(
                          size: 25.0,
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
