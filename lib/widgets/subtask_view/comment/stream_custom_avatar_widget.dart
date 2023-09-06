import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_view_bloc/subtask_view_bloc.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/future_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:badges/badges.dart' as badges;
import 'package:task_managing_application/widgets/shimmer/shimmer_config.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_loading.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_wrapper.dart';

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
                // badgeContent: DefaultTextStyle.merge(
                //   style: context.textTheme.bodySmall,
                //   child: Text(
                //     state.notifications!.length.toString(),
                //     style: widget.badgeTextStyle ??
                //         TextStyle(
                //           color: context.colorScheme.onSecondary,
                //           fontSize: 14.0,
                //           fontWeight: FontWeight.w500,
                //         ),
                //   ),
                // ),
                child: FutureAvatarWidget(
                  avatarRatio: widget.avatarRatio,
                  radiusRatio: widget.radiusRatio,
                  imageUrl: snapshot.data as String,
                  onTap: (context) {},
                ),
              );
            }
            return Center(
                child: Shimmer(
              linearGradient: shimmer_gradient,
              child: ShimmerLoading(
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),
            ));
          },
        );
      },
    );
  }
}
