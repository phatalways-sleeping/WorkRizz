import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class CustomErrorIcon extends StatelessWidget {
  const CustomErrorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.error,
      color: context.colorScheme.error,
      size: 25.0,
    );
  }
}
