import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/future_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/project_invitation/invitation_bloc/invitation_bloc.dart';
import 'package:task_managing_application/widgets/project_invitation/reply_button.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_config.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_loading.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_wrapper.dart';

class InvitationWidget extends StatefulWidget {
  const InvitationWidget({
    super.key,
    required this.invitationId,
  });

  final String invitationId;

  @override
  State<InvitationWidget> createState() => _InvitationWidgetState();
}

class _InvitationWidgetState extends State<InvitationWidget> {
  @override
  void initState() {
    context.read<InvitationBloc>().add(
          InvitationSubscribeToStream(
            widget.invitationId,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationBloc, InvitationState>(
      builder: (context, state) {
        if (state is InvitationInitial) {
          return Shimmer(
            linearGradient: shimmer_gradient,
            child: ShimmerLoading(
              child: Container(
                width: context.mediaQuery.size.width * 0.9,
                height: context.mediaQuery.size.height * 0.1,
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          );
        }
        if (state is InvitationLoading) {
          return Container(
            width: context.mediaQuery.size.width * 0.9,
            height: context.mediaQuery.size.height * 0.1,
            decoration: ShapeDecoration(
              color: context.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is InvitationFailure) {
          return Container(
            width: context.mediaQuery.size.width * 0.9,
            height: context.mediaQuery.size.height * 0.1,
            decoration: ShapeDecoration(
              color: context.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Center(
              child: CustomErrorIcon(),
            ),
          );
        }
        return Container(
          width: context.mediaQuery.size.width * 0.9,
          height: context.mediaQuery.size.height * 0.13,
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder(
                future: context.read<InvitationBloc>().imageOfCreator(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Shimmer(
                        linearGradient: shimmer_gradient,
                        child: ShimmerLoading(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return FutureAvatarWidget(
                      avatarRatio: 0.08,
                      radiusRatio: 0.04,
                      imageUrl: snapshot.data as String,
                      onTap: (context) {},
                    );
                  }
                  return Center(
                    child: Shimmer(
                      linearGradient: shimmer_gradient,
                      child: ShimmerLoading(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle.merge(
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSecondary,
                      ),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: (state as InvitationSuccess)
                                  .projectInvitation
                                  .senderUsername,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (context.read<InvitationBloc>().isLeader) ...[
                              TextSpan(
                                text: " invited you to be ",
                                style: context.textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text: "a leader",
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.secondary,
                                ),
                              ),
                              TextSpan(
                                text: " of the project ",
                                style: context.textTheme.bodyMedium,
                              ),
                            ] else
                              TextSpan(
                                text: " invited you to join the project ",
                                style: context.textTheme.bodyMedium,
                              ),
                            TextSpan(
                              text: (state).projectInvitation.projectName,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.mediaQuery.size.height * 0.01,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ReplyButton(
                            name: 'Accept',
                            backgroundColor: context.colorScheme.primary,
                            onPressed: (context) => context
                                .read<InvitationBloc>()
                                .add(
                                  InvitationAccept(
                                    projectInvitationId: widget.invitationId,
                                  ),
                                ),
                          ),
                          const SizedBox(width: 8),
                          ReplyButton(
                            name: 'Decline',
                            backgroundColor: context.colorScheme.error,
                            onPressed: (context) => context
                                .read<InvitationBloc>()
                                .add(
                                  InvitationDecline(
                                    projectInvitationId: widget.invitationId,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
