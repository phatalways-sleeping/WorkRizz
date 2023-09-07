import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_config.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_loading.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_wrapper.dart';

class ShimmerSubTaskWidget extends StatelessWidget {
  const ShimmerSubTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: shimmer_gradient,
      child: ShimmerLoading(
        child: Column(
          children: [
            Container(
              width: context.mediaQuery.size.width,
              height: context.mediaQuery.size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  MEDIUM_CORNER,
                ),
              ),
            ),
            SizedBox(
              height: context.mediaQuery.size.width * 0.02,
            ),
            Container(
              width: context.mediaQuery.size.width,
              height: context.mediaQuery.size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  MEDIUM_CORNER,
                ),
              ),
            ),
            SizedBox(
              height: context.mediaQuery.size.width * 0.02,
            ),
            Container(
              width: context.mediaQuery.size.width,
              height: context.mediaQuery.size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  MEDIUM_CORNER,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
