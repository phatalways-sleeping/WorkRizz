import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/widgets.dart'
    show CustomNavigationBar;

class BaseScreen extends StatefulWidget {
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
      extendBody: true,
      bottomNavigationBar:
          !widget.hideNavigationBar ? const CustomNavigationBar() : null,
    );
  }
}
