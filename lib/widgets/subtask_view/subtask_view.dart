import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_view_bloc/subtask_view_bloc.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/future_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_confirm_change_dialog.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_download_snackbar.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_snackbar.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_subtask_completion.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/override_files_dialog.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';
import 'package:task_managing_application/widgets/subtask_view/input/description_input.dart';
import 'package:task_managing_application/widgets/subtask_view/input/duedate_input.dart';
import 'package:task_managing_application/widgets/subtask_view/input/review_score_input.dart';
import 'package:task_managing_application/widgets/subtask_view/input/score_input.dart';
import 'package:task_managing_application/widgets/subtask_view/comment/comment_list.dart';
import 'package:task_managing_application/widgets/widgets.dart';

part 'file_list.dart';
part 'review.dart';

// ignore: must_be_immutable
class SubTaskView extends StatefulWidget {
  const SubTaskView({
    super.key,
    required this.isLeader,
  });
  final bool isLeader;

  @override
  State<SubTaskView> createState() => _SubTaskViewState();
}

class _SubTaskViewState extends State<SubTaskView> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubtaskViewBloc, SubtaskViewState>(
      listener: (context, state) async {
        if (state is SubtaskViewFailureDueToNetwork) {
          final snackBar = createErrorSnackBar(
            context: context,
            error: state.error,
            onPressed: (context) => context
                .read<SubtaskViewBloc>()
                .add(const SubTaskSubscribeEvent()),
          );
          context.scaffoldMessenger.showSnackBar(snackBar).closed.then(
            (value) {
              context
                  .read<SubtaskViewBloc>()
                  .add(const SubTaskSubscribeEvent());
            },
          );
        }
        if (state is SubtaskViewFailureDueToDataIntegrity) {
          final snackBar = createErrorSnackBar(
            context: context,
            error: state.error,
            onPressed: (context) => context
                .read<SubtaskViewBloc>()
                .add(const SubTaskSubscribeEvent()),
          );
          context.scaffoldMessenger.showSnackBar(snackBar).closed.then(
            (value) {
              context
                  .read<SubtaskViewBloc>()
                  .add(const SubTaskSubscribeEvent());
            },
          );
        }
        if (state is SubTaskViewSuccessAskPermissionToOverrideFiles) {
          await showOverridePermissonDialog(
            onAccept: (context) => context.read<SubtaskViewBloc>().add(
                  SubTaskAcceptOverrideAttachments(
                    state.newfiles,
                  ),
                ),
            onDecline: (context) => context.read<SubtaskViewBloc>().add(
                  SubTaskRejectOverrideAttachments(state.newfiles),
                ),
            onError: (context) => context.read<SubtaskViewBloc>().add(
                  const SubTaskSubscribeEvent(),
                ),
            context: context,
          );
        } else if (state is SubTaskLoadingSubTaskCompletion) {
          createSubTaskCompletionSnackBar(
            context: context,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Update is underway...',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  'Please don\'t wait and do not modify the task.',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(
                  width: 50.0,
                ),
                const CustomCircularProgressIndicator(
                  color: GREEN,
                  size: 20.0,
                ),
              ],
            ),
          );
        } else if (state is SubtaskViewDownloadSuccess) {
          context.scaffoldMessenger
              .showSnackBar(customDownloadStateSnackBar(
                  context: context, successful: true))
              .closed
              .then(
            (value) {
              context.read<SubtaskViewBloc>().add(
                    const SubTaskSubscribeEvent(),
                  );
            },
          );
        } else if (state is SubtaskViewDownloadFail) {
          context.scaffoldMessenger
              .showSnackBar(customDownloadStateSnackBar(
                context: context,
                successful: false,
                message: state.message,
              ))
              .closed
              .then(
            (value) {
              context.read<SubtaskViewBloc>().add(
                    const SubTaskSubscribeEvent(),
                  );
            },
          );
        } else if (state is SubtaskViewDownloading) {
          context.scaffoldMessenger
              .showSnackBar(
                customDownloadSnackBar(
                  context: context,
                ),
              )
              .closed
              .then(
            (value) {
              context.read<SubtaskViewBloc>().add(
                    const SubTaskSubscribeEvent(),
                  );
            },
          );
        }
      },
      builder: (context, state) {
        if (state is SubtaskViewInitial) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCircularProgressIndicator(
                  color: context.colorScheme.primary,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                DefaultTextStyle.merge(
                  style: context.textTheme.displaySmall,
                  child: Text(
                    'Please wait, we are loading your data...',
                    style: TextStyle(
                      color: context.colorScheme.tertiary,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is SubtaskViewLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomCircularProgressIndicator(),
                const SizedBox(
                  height: 10.0,
                ),
                DefaultTextStyle.merge(
                  style: context.textTheme.displaySmall,
                  child: const Text(
                    'Loading...',
                    style: TextStyle(
                      color: BLACK,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is SubtaskViewFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomErrorIcon(),
                const SizedBox(
                  height: 10.0,
                ),
                DefaultTextStyle.merge(
                  style: context.textTheme.displaySmall?.copyWith(
                    color: context.colorScheme.error,
                  ),
                  child: const Text(
                    'Something went wrong, please try again.',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return SafeArea(
          child: BaseScreen(
            hideFloatingActionButton: false,
            hideNavigationBar: true,
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: CustomHeaderBar(
                    atHomePage: false,
                    upperChild: Text(
                      context.read<SubtaskViewBloc>().projectName,
                      style: context.textTheme.displaySmall?.copyWith(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    bottomChild: Row(
                      children: [
                        CheckboxWidget(
                          checkState:
                              (state is SubTaskViewSuccessRequestConfirmChange)
                                  ? state.markAsCompleted
                                  : (state as SubtaskViewSuccess).isCompleted,
                          onChanged: (value, context) {
                            if (value == null) {
                              return;
                            }
                            if (value == true) {
                              context.read<SubtaskViewBloc>().add(
                                    const SubTaskMarkSubTaskCompletedEvent(),
                                  );
                            } else {
                              context.read<SubtaskViewBloc>().add(
                                    const SubTaskMarkSubTaskUncompletedEvent(),
                                  );
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SizedBox(
                            width: context.mediaQuery.size.width * 0.72,
                            child: DefaultTextStyle.merge(
                              style: context.textTheme.displaySmall?.copyWith(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                              child: Text(
                                (state as SubtaskViewSuccess).name,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: (context) async {
                      // debugPrint((state is SubTaskViewSuccessRequestConfirmChange).toString());
                      if (state is SubTaskViewSuccessRequestConfirmChange) {
                        await showConfirmChangeDialog(
                          onAccept: (context) => context
                              .read<SubtaskViewBloc>()
                              .add(
                                  const SubTaskConfirmChangePermissionsEvent()),
                          onDecline: (context) => context
                                  .read<NavigationBloc>()
                                  .state is SubTaskDetailFromHome
                              ? context.read<NavigationBloc>().add(
                                    const NavigateToHome(),
                                  )
                              : context.read<NavigationBloc>().add(
                                    const NavigateToTask(
                                      projectId: null,
                                      leaderId: null,
                                      projectName: null,
                                    ),
                                  ),
                          onError: (context) {},
                          context: context,
                        ).then(
                          (value) => context.read<NavigationBloc>().state
                                  is SubTaskDetailFromHome
                              ? context.read<NavigationBloc>().add(
                                    const NavigateToHome(),
                                  )
                              : context.read<NavigationBloc>().add(
                                    const NavigateToTask(
                                      projectId: null,
                                      leaderId: null,
                                      projectName: null,
                                    ),
                                  ),
                        );
                      } else {
                        context.read<NavigationBloc>().state
                                is SubTaskDetailFromHome
                            ? context.read<NavigationBloc>().add(
                                  const NavigateToHome(),
                                )
                            : context.read<NavigationBloc>().add(
                                  const NavigateToTask(
                                    projectId: null,
                                    leaderId: null,
                                    projectName: null,
                                  ),
                                );
                      }
                    },
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        context.mediaQuery.size.width * RATIO_PADDING + 5.0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('By', style: context.textTheme.titleSmall),
                                SizedBox(
                                  width: context.mediaQuery.size.width *
                                      RATIO_PADDING,
                                ),
                                FutureBuilder(
                                  future: context
                                      .read<SubtaskViewBloc>()
                                      .assigneeImage(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Icon(
                                        Icons.error,
                                        color: context.colorScheme.error,
                                        size: 20.0,
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      return FutureAvatarWidget(
                                        avatarRatio: 0.04,
                                        radiusRatio: 0.02,
                                        imageUrl: snapshot.data as String,
                                        onTap: (context) {},
                                      );
                                    }
                                    return const CustomCircularProgressIndicator(
                                      size: 15.0,
                                    );
                                  },
                                )
                              ],
                            ),
                            SvgPicture.string(SvgAssets.tdot)
                          ],
                        ),
                        SizedBox(
                            height:
                                context.mediaQuery.size.width * RATIO_PADDING),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Due Date',
                                  style:
                                      context.textTheme.displaySmall?.copyWith(
                                    fontSize: 16.0,
                                  ),
                                ),
                                widget.isLeader
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 0.01 *
                                                context.mediaQuery.size.width,
                                          ),
                                          DueDateInputWidget(
                                            input: state.dueDate,
                                            execute: (BuildContext context,
                                                    DateTime dateTime) =>
                                                context
                                                    .read<SubtaskViewBloc>()
                                                    .add(
                                                      SubTaskInputDueDateEvent(
                                                          dateTime),
                                                    ),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        width:
                                            context.mediaQuery.size.width * 0.4,
                                        margin: EdgeInsets.only(
                                            top: context.mediaQuery.size.width *
                                                0.01),
                                        decoration: BoxDecoration(
                                          // border black, size 1, round corner 12
                                          border: Border.all(
                                            color: BLACK,
                                            width: BORDER_WIDTH,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              MEDIUM_CORNER),
                                        ),
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                RATIO_PADDING),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.date_range_rounded,
                                                color: PALE),
                                            SizedBox(
                                                width: context
                                                        .mediaQuery.size.width *
                                                    RATIO_PADDING),
                                            Text(
                                              "${convertMonthToString((state.dueDate).month)} ${(state.dueDate).day}${(state.dueDate).day == 1 ? 'st' : (state.dueDate).day == 2 ? 'nd' : (state.dueDate).day == 3 ? 'rd' : 'th'} ${(state.dueDate).year}",
                                              style: context
                                                  .textTheme.titleSmall
                                                  ?.copyWith(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Points',
                                  style:
                                      context.textTheme.displaySmall?.copyWith(
                                    fontSize: 16.0,
                                  ),
                                ),
                                widget.isLeader
                                    ? Container(
                                        margin: EdgeInsets.only(
                                          top: context.mediaQuery.size.width *
                                              0.01,
                                        ),
                                        width: context.mediaQuery.size.width *
                                            0.45,
                                        child: ScoreInput(
                                          initialValue: state.points.toString(),
                                          listener: (context, controller) =>
                                              context
                                                  .read<SubtaskViewBloc>()
                                                  .add(
                                                    SubTaskInputPointsEvent(
                                                      int.parse(
                                                          controller.text),
                                                    ),
                                                  ),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            context.mediaQuery.size.width * 0.4,
                                        margin: EdgeInsets.only(
                                            top: context.mediaQuery.size.width *
                                                0.01),
                                        decoration: BoxDecoration(
                                          // border black, size 1, round corner 12
                                          border: Border.all(
                                            color: BLACK,
                                            width: BORDER_WIDTH,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              MEDIUM_CORNER),
                                        ),
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                RATIO_PADDING),
                                        child: Row(
                                          children: [
                                            SvgPicture.string(
                                              SvgAssets.note,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      PINK, BlendMode.srcIn),
                                            ),
                                            SizedBox(
                                              width: context
                                                      .mediaQuery.size.width *
                                                  RATIO_PADDING,
                                            ),
                                            Text(
                                              '${state.points}pt',
                                              style: context
                                                  .textTheme.titleSmall
                                                  ?.copyWith(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                            height:
                                context.mediaQuery.size.width * RATIO_SPACE),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: context.textTheme.displaySmall?.copyWith(
                                fontSize: 16.0,
                              ),
                            ),
                            widget.isLeader
                                ? Column(
                                    children: [
                                      SizedBox(
                                          height:
                                              context.mediaQuery.size.width *
                                                  0.01),
                                      DescriptionInput(
                                        label: 'Description',
                                        showLabel: false,
                                        initialValue: state.description,
                                        listener: (context, controller) =>
                                            context.read<SubtaskViewBloc>().add(
                                                  SubTaskInputDescriptionEvent(
                                                    controller.text.trim(),
                                                  ),
                                                ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    // width: max available width, finite
                                    width: double.maxFinite,
                                    height:
                                        context.mediaQuery.size.height * 0.1,
                                    margin: EdgeInsets.only(
                                        top: context.mediaQuery.size.width *
                                            0.01),
                                    decoration: BoxDecoration(
                                      // border black, size 1, round corner 12
                                      border: Border.all(
                                        color: BLACK,
                                        width: BORDER_WIDTH,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(MEDIUM_CORNER),
                                    ),
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            RATIO_PADDING),
                                    child: Text(
                                      state.description,
                                      style: context.textTheme.titleSmall,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                            height:
                                context.mediaQuery.size.width * RATIO_SPACE),
                        FileList(
                          isAssigned:
                              context.read<SubtaskViewBloc>().isAssigned,
                          isLeader: widget.isLeader,
                          files: state.files.map((e) => e.fileName).toList(),
                        ),
                        SizedBox(
                          height: context.mediaQuery.size.width * RATIO_PADDING,
                        ),
                        Comment(
                          isAssigned:
                              context.read<SubtaskViewBloc>().isAssigned,
                          isLeader: widget.isLeader,
                          comments: state.comments,
                        ),
                        SizedBox(
                          height: context.mediaQuery.size.width * RATIO_PADDING,
                        ),
                        Review(
                          isLeader: widget.isLeader,
                          progress: state.progress,
                          grade: state.grade,
                          leaderReview: state.leaderComment,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
