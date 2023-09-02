import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/widgets.dart'
    show CustomNavigationBar;

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.child,
    this.hideAppBar = true,
    this.hideNavigationBar = false,
  });

  final Widget child;
  final bool hideAppBar;
  final bool hideNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            if (!hideAppBar)
              const SliverPersistentHeader(
                pinned: true,
                delegate: CustomHeaderBar(
                  // atHomePage: false,
                  // onPressed: (context) {

                  // },
                  upperChild: Text('Hello Liana'),
                  bottomChild: Text('Today is Sunday'),
                ),
              ),
            SliverToBoxAdapter(
              child: child,
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: !hideAppBar ? const CustomNavigationBar() : null,
    );
  }
}
