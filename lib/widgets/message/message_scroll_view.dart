import 'package:flutter/material.dart';
import 'package:task_managing_application/models/thread/message/base/message_model.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';
import 'package:task_managing_application/states/message_bloc/message_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/future_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/message/message_widget.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_avatar.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_box.dart';
import 'package:badges/badges.dart' as badges;

class MessageScrollView extends StatefulWidget {
  const MessageScrollView({super.key});

  @override
  State<MessageScrollView> createState() => _MessageScrollViewState();
}

class _MessageScrollViewState extends State<MessageScrollView> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    // scrollController.animateTo(scrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state is MessageInitial || state is MessageLoading) {
          return SizedBox(
            height: context.mediaQuery.size.height * 0.77,
            child: ListView.separated(
              itemBuilder: (context, index) => ShimmerBox(
                width: context.mediaQuery.size.width * 0.7,
                height: 50.0,
              ),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: context.mediaQuery.size.width * RATIO_SPACE * 2,
                );
              },
              itemCount: 4,
            ),
          );
        }
        if (state is MessageError) {
          return SizedBox(
            height: context.mediaQuery.size.height * 0.77,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'An error occured',
                    style: context.textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: context.mediaQuery.size.width * RATIO_SPACE * 2,
                  ),
                  const CustomErrorIcon(),
                ],
              ),
            ),
          );
        }
        return SizedBox(
          height: context.mediaQuery.size.height * 0.77,
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: (state as MessageSuccess).messageIds.length,
            itemBuilder: (BuildContext context, int index) {
              return FutureBuilder(
                future: context.read<MessageBloc>().messageFuture(
                      (state).messageIds[index],
                    ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final message = snapshot.data as MessageModel;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!context
                            .read<MessageBloc>()
                            .isSender(message.sender))
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: context.mediaQuery.size.width *
                                    RATIO_PADDING,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FutureBuilder(
                                    future: context
                                        .read<MessageBloc>()
                                        .avatarUrlFuture(message.sender),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return StreamBuilder(
                                          stream: context
                                              .read<MessageBloc>()
                                              .userActivityStream(
                                                message.sender,
                                              ),
                                          builder: (context, snapshot1) {
                                            if (snapshot1.hasError) {
                                              return const ShimmerAvatar(
                                                avatarRatio: 0.04,
                                                radiusRatio: 0.02,
                                              );
                                            }
                                            if (snapshot1.hasData) {
                                              final userActivityModel =
                                                  snapshot1.data
                                                      as UserActivityModel;
                                              return badges.Badge(
                                                position: badges.BadgePosition
                                                    .bottomEnd(
                                                  bottom: 2,
                                                  end: 1,
                                                ),
                                                badgeStyle: badges.BadgeStyle(
                                                  badgeColor:
                                                      userActivityModel.isActive
                                                          ? context.colorScheme
                                                              .primary
                                                          : Colors.transparent,
                                                  borderRadius:
                                                      userActivityModel.isActive
                                                          ? BorderRadius
                                                              .circular(
                                                              12.0,
                                                            )
                                                          : BorderRadius.zero,
                                                  elevation:
                                                      userActivityModel.isActive
                                                          ? 4.0
                                                          : 0.0,
                                                  padding: userActivityModel
                                                          .isActive
                                                      ? const EdgeInsets.all(
                                                          6.0,
                                                        )
                                                      : EdgeInsets.zero,
                                                ),
                                                badgeAnimation: const badges
                                                    .BadgeAnimation.scale(
                                                  animationDuration: Duration(
                                                    milliseconds: 800,
                                                  ),
                                                ),
                                                child: FutureAvatarWidget(
                                                  onTap: (context) {},
                                                  imageUrl:
                                                      snapshot.data as String,
                                                  avatarRatio: 0.04,
                                                  radiusRatio: 0.02,
                                                ),
                                              );
                                            }
                                            return const ShimmerAvatar(
                                              avatarRatio: 0.04,
                                              radiusRatio: 0.02,
                                            );
                                          },
                                        );
                                      }
                                      return const ShimmerAvatar(
                                        avatarRatio: 0.04,
                                        radiusRatio: 0.02,
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: context.mediaQuery.size.width *
                                        RATIO_PADDING,
                                  ),
                                  FutureBuilder(
                                    future: context
                                        .read<MessageBloc>()
                                        .usernameFuture(message.sender),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data as String,
                                          style: context.textTheme.labelMedium,
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (context
                            .read<MessageBloc>()
                            .isSender(message.sender))
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: context.mediaQuery.size.width *
                                    RATIO_PADDING,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FutureBuilder(
                                    future: context
                                        .read<MessageBloc>()
                                        .usernameFuture(message.sender),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data as String,
                                          style: context.textTheme.labelMedium,
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                  SizedBox(
                                    width: context.mediaQuery.size.width *
                                        RATIO_PADDING,
                                  ),
                                  FutureBuilder(
                                    future: context
                                        .read<MessageBloc>()
                                        .avatarUrlFuture(message.sender),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return CustomAvatarWidget(
                                          imageUrl: snapshot.data as String,
                                        );
                                      }
                                      return const ShimmerAvatar(
                                        avatarRatio: 0.04,
                                        radiusRatio: 0.02,
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: context.mediaQuery.size.width *
                                        RATIO_PADDING,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Align(
                          alignment: context
                                  .read<MessageBloc>()
                                  .isSender(message.sender)
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: MessageWidget(
                            message: message,
                          ),
                        ),
                        SizedBox(
                          height:
                              context.mediaQuery.size.width * RATIO_SPACE * 2,
                        ),
                      ],
                    );
                  }
                  return ShimmerBox(
                    width: context.mediaQuery.size.width * 0.7,
                    height: 50.0,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
