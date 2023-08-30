import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/authentication_bloc/authentication_bloc.dart';
import 'package:task_managing_application/states/navigation_bloc/navigation_bloc.dart';

import 'forget_password_container.dart';
import 'login_container.dart';
import 'sigup_container.dart';
import 'starting_container.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  late final Animation<double> _animation = CurvedAnimation(
      parent: _controller, curve: Curves.fastEaseInToSlowEaseOut);

  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Stack(
        children: [
          // Image.asset(
          //   'assets/images/background.jpg',
          //   fit: BoxFit.cover,
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   filterQuality: FilterQuality.high,
          // ),
          // Container(
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   color: context.colorScheme.primary.withOpacity(0.3),
          // ),
          BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is SuccessfulAuthenticatedState) {
                context.read<NavigationBloc>().add(const NavigateToHome());
              }
            },
            builder: (context, state) {
              if (state is StartingState) {
                return const Align(
                  alignment: Alignment.bottomCenter,
                  child: StartingContainer(),
                );
              }
              if (state is AuthenticationBySignInState ||
                  state is FailureAuthenticationBySigninState ||
                  state is AuthenticationBySignInProgressingState) {
                return const Align(
                  alignment: Alignment.bottomCenter,
                  child: LoginContainer(),
                );
              }
              if (state is AuthenticationBySignUpState ||
                  state is AuthenticationBySignUpProgressingState ||
                  state is FailureAuthenticationBySignupState) {
                return const Align(
                  alignment: Alignment.bottomCenter,
                  child: SignUpContainer(),
                );
              }
              if (state is ForgetPasswordProgressingState ||
                  state is ForgetPasswordState ||
                  state is FailureForgetPasswordState) {
                return const Align(
                  alignment: Alignment.bottomCenter,
                  child: ForgetPasswordContainer(),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
