import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

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
