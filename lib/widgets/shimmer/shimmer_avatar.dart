import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

import 'shimmer_config.dart';
import 'shimmer_loading.dart';
import 'shimmer_wrapper.dart';

class ShimmerAvatar extends StatelessWidget {
  const ShimmerAvatar({
    super.key,
    this.avatarRatio = 0.06,
    this.radiusRatio = 0.03,
  });

  final double avatarRatio;
  final double radiusRatio;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer(
        linearGradient: shimmer_gradient,
        child: ShimmerLoading(
          child: Container(
            width: context.mediaQuery.size.width * avatarRatio,
            height: context.mediaQuery.size.width * avatarRatio,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
