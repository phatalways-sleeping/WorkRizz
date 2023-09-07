import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_view_bloc/subtask_view_bloc.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/future_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:badges/badges.dart' as badges;
import 'package:task_managing_application/widgets/shimmer/shimmer_avatar.dart';

class StreamCustomAvatarWidget extends StatefulWidget {
  const StreamCustomAvatarWidget({
    super.key,
    required this.userId,
    this.avatarRatio = 0.06,
    this.radiusRatio = 0.03,
    this.badgeTextStyle,
  });

  final String userId;
  final double radiusRatio;
  final double avatarRatio;
  final TextStyle? badgeTextStyle;

  @override
  State<StreamCustomAvatarWidget> createState() =>
      _StreamCustomAvatarWidgetState();
}

class _StreamCustomAvatarWidgetState extends State<StreamCustomAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<SubtaskViewBloc>().imageUrlOf(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerAvatar(
            avatarRatio: 0.06,
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: CustomErrorIcon(),
          );
        }
        return StreamBuilder(
          stream: context.read<SubtaskViewBloc>().userActivityStream(
                widget.userId,
              ),
          builder: (context, snapshotStream) {
            if (snapshotStream.hasError) {
              return const Center(
                child: CustomErrorIcon(),
              );
            }
            if (snapshotStream.hasData) {
              final userActivityModel =
                  snapshotStream.data as UserActivityModel;
              return badges.Badge(
                position: badges.BadgePosition.bottomEnd(bottom: 4, end: 3),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: userActivityModel.isActive
                      ? context.colorScheme.primary
                      : Colors.transparent,
                  borderRadius: userActivityModel.isActive
                      ? BorderRadius.circular(
                          context.mediaQuery.size.height *
                              widget.radiusRatio *
                              0.5,
                        )
                      : BorderRadius.zero,
                  elevation: userActivityModel.isActive ? 4.0 : 0.0,
                  padding: userActivityModel.isActive
                      ? const EdgeInsets.all(6.0)
                      : EdgeInsets.zero,
                ),
                badgeAnimation: const badges.BadgeAnimation.scale(
                  animationDuration: Duration(milliseconds: 800),
                ),
                child: FutureAvatarWidget(
                  avatarRatio: widget.avatarRatio,
                  radiusRatio: widget.radiusRatio,
                  imageUrl: snapshot.data as String,
                  onTap: (context) {},
                ),
              );
            }
            return const Center(
              child: ShimmerAvatar(
                avatarRatio: 0.04,
                radiusRatio: 0.02,
              ),
            );
          },
        );
      },
    );
  }
}
