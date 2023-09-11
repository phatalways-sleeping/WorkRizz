import 'package:cached_network_image/cached_network_image.dart';
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
    return FutureBuilder(
      future: precacheImage(
        CachedNetworkImageProvider(imageUrl),
        context,
      ),
      builder: (context, snapshot) {
        return InkWell(
          splashColor: Colors.transparent,
          splashFactory: InkSplash.splashFactory,
          onTap: () => onTap(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              context.mediaQuery.size.height * radiusRatio,
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorWidget: (context, url, error) => Shimmer(
                linearGradient: shimmer_gradient,
                child: ShimmerLoading(
                  child: Container(
                    height: context.mediaQuery.size.height * avatarRatio,
                    width: context.mediaQuery.size.height * avatarRatio,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(
                        context.mediaQuery.size.height * radiusRatio,
                      ),
                    ),
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, progress) =>
                  CircularProgressIndicator(
                value: progress.progress,
                color: ORANGE,
              ),
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: context.mediaQuery.size.height * avatarRatio,
                  width: context.mediaQuery.size.height * avatarRatio,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(
                      context.mediaQuery.size.height * radiusRatio,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
