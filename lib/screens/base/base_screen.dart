import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/repositories/repositories.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/widgets.dart'
    show CustomCircularProgressIndicator, CustomFloatingWidget, CustomNavigationBar;

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.read<ApplicationRepository>().updateUserActivity(true);
    }
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      context.read<ApplicationRepository>().updateUserActivity(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: FirebaseAuth.instance
          .authStateChanges()
          .map((event) => event != null),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: CustomErrorIcon(),
            ),
          );
        }
        if (snapshot.hasData && snapshot.data!) {
          return Scaffold(
            body: SafeArea(
              child: widget.child,
            ),
            backgroundColor: context.colorScheme.onPrimary,
            extendBody: true,
            floatingActionButtonLocation: widget.hideFloatingActionButton
                ? null
                : FloatingActionButtonLocation.endDocked,
            floatingActionButton: widget.hideFloatingActionButton
                ? null
                : const CustomFloatingWidget(),
            bottomNavigationBar:
                !widget.hideNavigationBar ? const CustomNavigationBar() : null,
          );
        }
        if (snapshot.hasData && !snapshot.data!) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomErrorIcon(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'An unusual traffic has been detected!',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: BLACK,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => context
                        .read<NavigationBloc>()
                        .add(const NavigateToRedirect()),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        context.colorScheme.error,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      fixedSize: MaterialStatePropertyAll(
                        Size(
                          context.mediaQuery.size.width * 0.5,
                          context.mediaQuery.size.height * 0.08,
                        ),
                      ),
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(
                          horizontal: context.mediaQuery.size.width * 0.05,
                          vertical: context.mediaQuery.size.height * 0.02,
                        ),
                      ),
                      overlayColor: MaterialStatePropertyAll(
                        context.colorScheme.error.withOpacity(0.5),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.comfortable,
                      alignment: Alignment.center,
                    ),
                    child: Text(
                      'Go back to login page',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: BLACK,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CustomCircularProgressIndicator(
              size: 30.0,
              color: PURPLE,
            ),
          ),
        );
      },
    );
  }
}
