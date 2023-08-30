import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';

class CustomHeaderBar extends SliverPersistentHeaderDelegate {
  const CustomHeaderBar({
    required this.username,
    required this.imageUrl,
    this.atHomePage = true,
    this.onPressed,
  }) : assert(atHomePage || onPressed != null);

  final String username;
  final String imageUrl;
  final bool atHomePage;
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
            if (atHomePage)
              DefaultTextStyle.merge(
                style: context.textTheme.displayMedium,
                child: Text(
                  'Hello $username!',
                  style: TextStyle(
                    color: context.colorScheme.onSecondary,
                    fontSize: 26,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
            const Spacer(),
            CustomAvatarWidget(
              imageUrl: imageUrl,
            ),
          ],
        ),
      ),
    );
  }
}
