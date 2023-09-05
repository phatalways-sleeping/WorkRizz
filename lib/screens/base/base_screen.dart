import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/widgets.dart'
    show CustomFloatingWidget, CustomNavigationBar;

class BaseScreen extends StatefulWidget {
  const BaseScreen({
    super.key,
    required this.child,
    this.hideNavigationBar = false,
    required this.hideFloatingActionButton,
  });

  final Widget child;
  final bool hideNavigationBar;
  final bool hideFloatingActionButton;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) {
  //     context.read<ApplicationRepository>().updateUserActivity(true);
  //   }
  //   if (state == AppLifecycleState.paused ||
  //       state == AppLifecycleState.inactive) {
  //     context.read<ApplicationRepository>().updateUserActivity(false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      backgroundColor: context.colorScheme.onPrimary,
      extendBody: true,
      floatingActionButtonLocation: widget.hideFloatingActionButton
          ? null
          : FloatingActionButtonLocation.endDocked,
      floatingActionButton: widget.hideFloatingActionButton ? null : const CustomFloatingWidget(),
      bottomNavigationBar:
          !widget.hideNavigationBar ? const CustomNavigationBar() : null,
    );
  }
}
