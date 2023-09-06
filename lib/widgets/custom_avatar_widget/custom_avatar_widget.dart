import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/extensions/build_context_extensions.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_config.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_loading.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_wrapper.dart';

class CustomAvatarWidget extends StatelessWidget {
  const CustomAvatarWidget({
    super.key,
    required this.imageUrl,
    this.size = 40.0,
  });
  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.network(
            imageUrl,
            height: size,
            width: size,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
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
      ],
    );
  }
}
