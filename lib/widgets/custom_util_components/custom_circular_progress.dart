import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
    this.size,
    this.color,
  });
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? context.mediaQuery.size.width * 0.1,
      height: size ?? context.mediaQuery.size.width * 0.1,
      child: CircularProgressIndicator(
        color: color ?? context.colorScheme.secondary,
      ),
    );
  }
}
