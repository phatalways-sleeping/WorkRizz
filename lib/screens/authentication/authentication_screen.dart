import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/authentication/authentication_view.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  AuthenticationView(),
    );
  }
}