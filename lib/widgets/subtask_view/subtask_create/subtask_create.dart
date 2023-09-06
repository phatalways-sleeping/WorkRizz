import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_create_bloc/subtask_create_bloc.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_snackbar.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';
import 'package:task_managing_application/widgets/subtask_view/input/description_input.dart';
import 'package:task_managing_application/widgets/subtask_view/input/duedate_input.dart';
import 'package:task_managing_application/widgets/subtask_view/input/score_input.dart';
import 'package:task_managing_application/widgets/subtask_view/subtask_create/assignee_adder.dart';
import 'file.dart';

// ignore: must_be_immutable
class SubTaskCreateView extends StatelessWidget {
  final Function()? changeColor;

  const SubTaskCreateView({
    super.key,
    this.changeColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubtaskCreateBloc, SubtaskCreateState>(
      listener: (context, state) {
        if (state is SubTaskCreateFailureDueToDataIntegrity) {
          final snackBar = createErrorSnackBar(
            context: context,
            error: state.error,
            onPressed: (context) => context.read<SubtaskCreateBloc>().add(
                  const SubTaskCreateSubscribeToTaskEvent(),
                ),
          );
          context.scaffoldMessenger.showSnackBar(snackBar).closed.then(
                (value) => context.read<SubtaskCreateBloc>().add(
                      const SubTaskCreateSubscribeToTaskEvent(),
                    ),
              );
        }
        if (state is SubtaskCreateFailureDueToNetwork) {
          final snackBar = createErrorSnackBar(
            context: context,
            error: 'Your internet connection is unstable',
            onPressed: (context) => context.read<SubtaskCreateBloc>().add(
                  const SubTaskCreateSubscribeToTaskEvent(),
                ),
          );
          context.scaffoldMessenger.showSnackBar(snackBar).closed.then(
                (value) => context.read<SubtaskCreateBloc>().add(
                      const SubTaskCreateSubscribeToTaskEvent(),
                    ),
              );
        }
      },
      builder: (context, state) {
        if (state is SubtaskCreateInitial) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        }
        if (state is SubtaskCreateLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCircularProgressIndicator(
                  color: context.colorScheme.primary,
                ),
                const SizedBox(height: 10.0),
                DefaultTextStyle.merge(
                  style: context.textTheme.bodyLarge,
                  child: const Text(
                    'Creating subtask...',
                    style: TextStyle(
                      color: BLACK,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
        }
        if (state is SubTaskCreateFailureDueToDataIntegrity) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomErrorIcon(),
                const SizedBox(height: 10.0),
                DefaultTextStyle.merge(
                  style: context.textTheme.bodyLarge,
                  child: const Text(
                    'Ouch! Please fill in all the fields',
                    style: TextStyle(
                      color: BLACK,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is SubtaskCreateFailureDueToNetwork) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomErrorIcon(),
                const SizedBox(height: 10.0),
                DefaultTextStyle.merge(
                  style: context.textTheme.bodyLarge,
                  child: const Text(
                    'Ouch! Please check your internet connection',
                    style: TextStyle(
                      color: BLACK,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return SafeArea(
          child: BaseScreen(
            hideFloatingActionButton: true,
            hideNavigationBar: true,
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: CustomHeaderBar(
                    atHomePage: false,
                    upperChild: Text(
                      (state as SubtaskCreateSuccess).projectName,
                      style: context.textTheme.displaySmall?.copyWith(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    bottomChild: const Text("Assign new task to a person"),
                    onPressed: (context) => context.read<NavigationBloc>().add(
                          const NavigateToTask(null),
                        ),
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
                                        RATIO_PADDING),
                                const AssigneeAdder(),
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
                                  style: context.textTheme.displaySmall?.copyWith(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          0.01 * context.mediaQuery.size.width,
                                    ),
                                    DueDateInputWidget(
                                      execute: (BuildContext context,
                                              DateTime dateTime) =>
                                          context.read<SubtaskCreateBloc>().add(
                                                SubTaskInputDueDateEvent(
                                                  dateTime,
                                                ),
                                              ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Points',
                                  style: context.textTheme.displaySmall?.copyWith(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: context.mediaQuery.size.width * 0.01),
                                  width: context.mediaQuery.size.width * 0.4,
                                  child: const ScoreInput(),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                            height: context.mediaQuery.size.width * RATIO_SPACE),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title',
                              style: context.textTheme.displaySmall?.copyWith(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(
                                height: context.mediaQuery.size.width * 0.01),
                            const DescriptionInput(
                              label: 'Title',
                              showLabel: false,
                            ),
                            SizedBox(
                                height:
                                    context.mediaQuery.size.width * RATIO_SPACE),
                            Text(
                              'Description',
                              style: context.textTheme.displaySmall?.copyWith(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(
                                height: context.mediaQuery.size.width * 0.01),
                            const DescriptionInput(
                              label: 'Description',
                              showLabel: false,
                            ),
                            SizedBox(
                                height:
                                    context.mediaQuery.size.width * RATIO_SPACE),
                          ],
                        ),
                        const CreateFile(),
                        SizedBox(
                            height:
                                context.mediaQuery.size.width * RATIO_PADDING),
                        ElevatedButton(
                          onPressed: () => context.read<SubtaskCreateBloc>().add(
                                const SubTaskRequestToCreateEvent(),
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
                            fixedSize: MaterialStatePropertyAll(
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
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
