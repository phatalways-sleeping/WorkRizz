import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:task_managing_application/assets/extensions/build_context_extensions.dart';
class CustomAvatarWidget extends StatefulWidget {
  const CustomAvatarWidget({
    super.key,
    required this.onTap,
    this.badgeTextStyle,
    this.avatarRatio = 0.06,
    this.radiusRatio = 0.03,
  });
  final void Function(BuildContext context) onTap;
  final TextStyle? badgeTextStyle;
  final double radiusRatio;
  final double avatarRatio;

  @override
  State<CustomAvatarWidget> createState() => _CustomAvatarWidgetState();
}

class _CustomAvatarWidgetState extends State<CustomAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(
            "https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg"),
        builder: (context, snapshot) {
          if (snapshot.hasError) {}
          if (snapshot.hasData) {
            return StreamBuilder(
              stream: Stream.fromIterable([1,2,3,4,5]),
              builder: (context, snapshot1) {
                if (snapshot1.hasError) {}
                if (snapshot1.hasData) {
                  return badges.Badge(
                    position: badges.BadgePosition.topEnd(end: -4.0),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: context.colorScheme.error,
                      borderRadius: BorderRadius.circular(
                        context.mediaQuery.size.height *
                            widget.radiusRatio *
                            0.08,
                      ),
                      elevation: 4.0,
                      padding: const EdgeInsets.all(6.0),
                    ),
                    badgeAnimation: const badges.BadgeAnimation.scale(
                      animationDuration: Duration(milliseconds: 800),
                    ),
                    badgeContent: DefaultTextStyle.merge(
                      style: context.textTheme.bodySmall,
                      child: Text(
                        snapshot1.data!.toString(),
                        style: widget.badgeTextStyle ??
                            TextStyle(
                              color: context.colorScheme.onSecondary,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    onTap: () => widget.onTap(context),
                    child: FutureAvatarWidget(
                      avatarRatio: widget.avatarRatio,
                      radiusRatio: widget.radiusRatio,
                      imageUrl: snapshot.data!,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            );
          }
          return const SizedBox.shrink();
        });
  }
}

class FutureAvatarWidget extends StatelessWidget {
  const FutureAvatarWidget({
    super.key,
    required this.avatarRatio,
    required this.radiusRatio,
    required this.imageUrl,
  });
  final double radiusRatio;
  final double avatarRatio;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        context.mediaQuery.size.height * radiusRatio,
      ),
      child: Image.network(
        imageUrl,
        height: context.mediaQuery.size.height * avatarRatio,
        width: context.mediaQuery.size.height * avatarRatio,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(
                color: context.colorScheme.secondary,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.error_outline_rounded,
              size: 20.0,
              color: context.colorScheme.error,
            ),
          );
        },
      ),
    );
  }
}
