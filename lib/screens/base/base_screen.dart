import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/widgets.dart'
    show CustomNavigationBar;

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
