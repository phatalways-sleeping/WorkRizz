import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/authentication_bloc/authentication_bloc.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer>
    with TickerProviderStateMixin {
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  late final Animation<double> _animation =
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate);

  @override
  void initState() {
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Container(
        width: double.infinity,
        height: 480.0,
        padding: const EdgeInsets.only(
          top: 20,
          left: 10.0,
          right: 10.0,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Enjoy the new experience',
              style: TextStyle(
                color: context.colorScheme.primary,
                fontFamily: 'Nunito',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'of chatting with global friends',
              style: TextStyle(
                color: context.colorScheme.primary,
                fontFamily: 'Nunito',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Connect with people around the world for free',
              style: TextStyle(
                color: context.colorScheme.primary,
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomInputField(
                    title: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    title: 'Password',
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClickableText(
                              disabled: state
                                  is AuthenticationBySignInProgressingState,
                              text: 'Forget Password?',
                              onPressed: (context) => context
                                  .read<AuthenticationBloc>()
                                  .add(const ForgetPasswordEvent())),
                          const Spacer(),
                          ClickableText(
                            disabled:
                                state is AuthenticationBySignInProgressingState,
                            text: 'Sign up',
                            onPressed: (context) {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(const SignUpEvent());
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is FailureAuthenticationBySigninState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      (context.read<AuthenticationBloc>().state
                              as FailureAuthenticationBySigninState)
                          .message,
                      style: const TextStyle(
                        color: Colors.red,
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationBySignInProgressingState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    child: CircularProgressIndicator(
                      color: context.colorScheme.primary,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: AuthenticatedButton(
                onPressed: (context) {
                  context.read<AuthenticationBloc>().add(
                        RequestSigninEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                  emailController.clear();
                  passwordController.clear();
                },
                text: 'Sign in',
              ),
            ),
            const Spacer(),
            Text(
              'Developed by slimreaper',
              style: TextStyle(
                color: context.colorScheme.primary,
                fontFamily: 'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
