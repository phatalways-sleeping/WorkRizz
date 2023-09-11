import 'package:flutter/material.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/widgets.dart' show SplashView;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashToHome) {
          context.read<NavigationBloc>().add(const NavigateToHome());
        } else if (state is SplashToLogin) {
          context.read<NavigationBloc>().add(const NavigateToAuthentication());
        }
      },
      child: const Scaffold(
        body: SplashView(),
      ),
    );
  }
}
