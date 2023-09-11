import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';

class RedirectScreen extends StatefulWidget {
  const RedirectScreen({super.key});

  @override
  State<RedirectScreen> createState() => _RedirectScreenState();
}

class _RedirectScreenState extends State<RedirectScreen> {
  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 3), () {
      context.read<NavigationBloc>().add(const NavigateToAuthentication());
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomCircularProgressIndicator(
              color: PURPLE,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'You have successfully logged out!',
              style: context.textTheme.bodyMedium?.copyWith(
                color: BLACK,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'We will redirect you to the login page in 3 seconds...',
              style: context.textTheme.bodyMedium?.copyWith(
                color: BLACK,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
