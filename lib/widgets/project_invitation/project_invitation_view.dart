import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/repositories/repositories.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_dialog.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_snackbar.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';
import 'package:task_managing_application/widgets/project_invitation/invitation_widget.dart';

import 'invitation_bloc/invitation_bloc.dart';

class ProjectInvitationsView extends StatefulWidget {
  const ProjectInvitationsView({super.key});

  @override
  State<ProjectInvitationsView> createState() => _ProjectInvitationsViewState();
}

class _ProjectInvitationsViewState extends State<ProjectInvitationsView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProjectInvitationBloc, UserProjectInvitationState>(
      listener: (context, state) async {
        if (state is UserProjectInvitationFailure) {
          final snackBar = createErrorSnackBar(
            context: context,
            error: state.message,
            onPressed: (context) => context
                .read<UserProjectInvitationBloc>()
                .add(const UserProjectInvitationSubscribeToStream()),
          );
          context.scaffoldMessenger.showSnackBar(
            snackBar,
          );
        }

        if (state is UserProjectInvitationSuccessConfirmLogout) {
          await showDialog<bool>(
            context: context,
            builder: (context) => CustomDialog(
              title: 'Log out',
              leftText: 'Agree',
              rightText: 'Cancel',
              leftColor: PURPLE,
              rightColor: PINK,
              focusleftColor: PURPLE,
              focusrightColor: PINK,
              onLeftPressed: (context) => Navigator.of(context).pop(true),
              onRightPressed: (context) => Navigator.of(context).pop(false),
            ),
          ).then(
            (value) {
              if (value != null && value) {
                context
                    .read<NavigationBloc>()
                    .add(const NavigateToRedirect());
              } else {
                context
                    .read<UserProjectInvitationBloc>()
                    .add(const UserProjectInvitationCancelRequest());
              }
            },
          ).onError(
            (error, stackTrace) {
              context
                  .read<UserProjectInvitationBloc>()
                  .add(const UserProjectInvitationCancelRequest());
            },
          );
        }
      },
      builder: (context, state) {
        if (state is UserProjectInvitationInitial) {
          return const Center(
            child: CustomCircularProgressIndicator(
              size: 30.0,
            ),
          );
        }
        if (state is UserProjectInvitationLoading) {
          return const Center(
            child: CustomCircularProgressIndicator(
              size: 30.0,
            ),
          );
        }
        if (state is UserProjectInvitationSuccess) {
          return BaseScreen(
            hideNavigationBar: true,
            hideFloatingActionButton: true,
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomHeaderBar(
                    onPressed: (context) =>
                        context.read<NavigationBloc>().navigateBack(),
                    atHomePage: false,
                    hideAvatar: true,
                    upperChild: const SizedBox.shrink(),
                    trailing: InkWell(
                      onTap: () => context
                          .read<UserProjectInvitationBloc>()
                          .add(const UserProjectInvitationRequestToLogout()),
                      child: SvgPicture.string(
                        SvgAssets.logout,
                        fit: BoxFit.cover,
                        width: context.mediaQuery.size.width * 0.05,
                        height: context.mediaQuery.size.width * 0.05,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onSecondary,
                          BlendMode.srcATop,
                        ),
                      ),
                    ),
                    bottomChild: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: context.mediaQuery.size.width * 0.1,
                          height: context.mediaQuery.size.width * 0.1,
                          padding: EdgeInsets.all(
                            context.mediaQuery.size.width * 0.02,
                          ),
                          decoration: ShapeDecoration(
                            color: context.colorScheme.onErrorContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                7,
                              ),
                            ),
                          ),
                          child: SvgPicture.string(
                            SvgAssets.notification,
                            fit: BoxFit.cover,
                            width: context.mediaQuery.size.width * 0.05,
                            height: context.mediaQuery.size.width * 0.05,
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcATop,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Invitations (${state.projectInvitation!.length})",
                          style: context.textTheme.displayLarge?.copyWith(
                            color: context.colorScheme.onSecondary,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        context.mediaQuery.size.width * RATIO_MARGIN * 0.7,
                    vertical:
                        context.mediaQuery.size.height * RATIO_MARGIN * 0.7,
                  ),
                  sliver: SliverList.separated(
                    itemCount: state.projectInvitation!.length,
                    itemBuilder: (context, index) => BlocProvider(
                      create: (context) => InvitationBloc(
                        context.read<ApplicationRepository>(),
                      ),
                      child: InvitationWidget(
                        invitationId: state.projectInvitation![index],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CustomErrorIcon(),
        );
      },
    );
  }
}
