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
        height: context.mediaQuery.size.height * 0.38,
        padding: EdgeInsets.only(
          top: context.mediaQuery.size.height * RATIO_PADDING * 0.3,
          left: context.mediaQuery.size.width * RATIO_PADDING,
          right: context.mediaQuery.size.width * RATIO_PADDING,
        ),
        decoration: ShapeDecoration(
          color: context.colorScheme.onPrimary,
          shape: const RoundedRectangleBorder(
            side: BorderSide(width: 1.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextStyle.merge(
              style: context.textTheme.bodyLarge,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Manage your work ',
                      style: TextStyle(
                        color: context.colorScheme.onSecondary,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'effortlessly',
                      style: TextStyle(
                        color: context.colorScheme.secondary,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_MARGIN * 0.3,
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
                  SizedBox(
                    height: context.mediaQuery.size.height * RATIO_MARGIN * 0.3,
                  ),
                  CustomInputField(
                    title: 'Password',
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: context.mediaQuery.size.height * RATIO_MARGIN * 0.2,
                  ),
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
                    padding: EdgeInsets.only(
                      top: context.mediaQuery.size.height * RATIO_PADDING * 0.2,
                    ),
                    child: DefaultTextStyle.merge(
                      style: context.textTheme.bodyMedium,
                      child: Text(
                        (context.read<AuthenticationBloc>().state
                                as FailureAuthenticationBySigninState)
                            .message,
                        style: TextStyle(
                          color: context.colorScheme.error,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
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
                    padding: EdgeInsets.symmetric(
                      vertical:
                          context.mediaQuery.size.height * RATIO_PADDING * 0.2,
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
              padding: EdgeInsets.symmetric(
                vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.3,
              ),
              child: AuthenticatedButton(
                onPressed: (context) {
                  context.read<AuthenticationBloc>().add(
                        RequestSigninEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );

                  passwordController.clear();
                },
                text: 'Get Started',
              ),
            ),
            const Spacer(),
            DefaultTextStyle.merge(
              style: context.textTheme.bodyMedium,
              child: Text(
                'Developed by PVB',
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_MARGIN * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
