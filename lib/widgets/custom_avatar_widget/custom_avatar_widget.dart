import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/extensions/build_context_extensions.dart';

class CustomAvatarWidget extends StatelessWidget {
  const CustomAvatarWidget({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.network(
            imageUrl,
            height: 40.0,
            width: 40.0,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
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
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            width: 20.0,
            height: 20.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.error,
              shape: BoxShape.circle,
            ),
            child: DefaultTextStyle.merge(
              style: context.textTheme.bodySmall,
              child: const Text(
                '3',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
