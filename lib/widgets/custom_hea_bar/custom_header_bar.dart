import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/repositories/repositories.dart';
import 'package:task_managing_application/states/avatar_bloc/avatar_bloc.dart';
import 'package:task_managing_application/states/navigation_bloc/navigation_bloc.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/avatar_widget_badge.dart';

class CustomHeaderBar extends SliverPersistentHeaderDelegate {
  const CustomHeaderBar({
    required this.upperChild,
    required this.bottomChild,
    this.atHomePage = true,
    this.onPressed,
  }) : assert(atHomePage || onPressed != null);

  final bool atHomePage;
  final Widget upperChild;
  final Widget bottomChild;
  final void Function(BuildContext context)? onPressed;

  @override
  double get maxExtent => MAX_HEIGHT_APP_BAR;

  @override
  double get minExtent => MIN_HEIGHT_APP_BAR;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.mediaQuery.size.width * RATIO_PADDING,
          vertical: 5.0,
        ),
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
          ),
          color: context.colorScheme.onPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (atHomePage)
                    DefaultTextStyle.merge(
                      style: context.textTheme.displayMedium?.copyWith(
                        color: context.colorScheme.onSecondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.fade,
                      ),
                      child: upperChild,
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => onPressed!(context),
                          borderRadius: BorderRadius.circular(25.0),
                          radius: 20.0,
                          overlayColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.isPressed) {
                                return context.colorScheme.secondary;
                              }
                              return context.colorScheme.onSecondary;
                            },
                          ),
                          splashFactory: InkRipple.splashFactory,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 20.0,
                              color: context.colorScheme.onSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        DefaultTextStyle.merge(
                          style: context.textTheme.displayMedium?.copyWith(
                            color: context.colorScheme.onSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.fade,
                          ),
                          child: upperChild,
                        ),
                      ],
                    ),
                  // const Spacer(),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.mediaQuery.size.width * 0.8,
                    ),
                    child: DefaultTextStyle.merge(
                      style: context.textTheme.displayLarge?.copyWith(
                        color: context.colorScheme.onSecondary,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                      child: bottomChild,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            BlocProvider(
              create: (context) =>
                  AvatarBloc(context.read<ApplicationRepository>()),
              child: AvatarWidgetWithBadge(
                onTap: (context) {
                  if (context.read<NavigationBloc>().state
                      is! UserProjectInvitation) {
                    context.read<NavigationBloc>().mapCurrentStateToEventThenEmit(
                          context.read<NavigationBloc>().state,
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
