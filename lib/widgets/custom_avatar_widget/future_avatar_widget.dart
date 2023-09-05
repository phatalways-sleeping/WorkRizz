import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_config.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_loading.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_wrapper.dart';

class FutureAvatarWidget extends StatelessWidget {
  const FutureAvatarWidget({
    super.key,
    required this.avatarRatio,
    required this.radiusRatio,
    required this.imageUrl,
    required this.onTap,
  });
  final double radiusRatio;
  final double avatarRatio;
  final String imageUrl;
  final void Function(BuildContext context) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: InkSplash.splashFactory,
      onTap: () => onTap(context),
      child: ClipRRect(
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
      ),
    );
  }
}
