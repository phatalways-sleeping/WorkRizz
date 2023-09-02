import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';

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
        margin: EdgeInsets.symmetric(
          horizontal: context.mediaQuery.size.width * RATIO_MARGIN,
        ),
        decoration: const BoxDecoration(
          border: Border(),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (atHomePage)
                  DefaultTextStyle.merge(
                    style: context.textTheme.displayMedium?.copyWith(
                      color: context.colorScheme.onSecondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    child: upperChild,
                  )
                else
                  IconButton(
                    onPressed: () => onPressed!(context),
                    style: const ButtonStyle(
                      animationDuration: Duration(milliseconds: 100),
                      visualDensity: VisualDensity.comfortable,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.center,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 25.0,
                    ),
                  ),
                SizedBox(
                  height: context.mediaQuery.size.height * RATIO_MARGIN * 0.2,
                ),
                DefaultTextStyle.merge(
                  style: context.textTheme.displayLarge?.copyWith(
                    color: context.colorScheme.onSecondary,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                  child: bottomChild,
                ),
              ],
            ),
            const Spacer(),
            CustomAvatarWidget(
              onTap: (context) {},
            ),
          ],
        ),
      ),
    );
  }
}
