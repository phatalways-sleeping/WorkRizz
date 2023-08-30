import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/authentication_bloc/authentication_bloc.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';

class SignUpContainer extends StatefulWidget {
  const SignUpContainer({super.key});

  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer>
    with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

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
    confirmPasswordController.dispose();
    usernameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Container(
        width: double.infinity,
        height: context.mediaQuery.size.height * 0.52,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => context.read<AuthenticationBloc>().add(
                        const LoginEvent(),
                      ),
                  style: const ButtonStyle(
                    animationDuration: Duration(milliseconds: 100),
                    visualDensity: VisualDensity.comfortable,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center,
                  ),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20.0,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                DefaultTextStyle.merge(
                  style: context.textTheme.bodyLarge,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
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
                    label: 'Username',
                    hintText: 'Enter your username',
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: context.mediaQuery.size.height * RATIO_MARGIN * 0.3,
                  ),
                  CustomInputField(
                    label: 'Email',
                    hintText: 'What is your email?',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: context.mediaQuery.size.height * RATIO_MARGIN * 0.3,
                  ),
                  CustomInputField(
                    label: 'Password',
                    hintText: 'A password must has at least 7 characters',
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: context.mediaQuery.size.height * RATIO_MARGIN * 0.3,
                  ),
                  CustomInputField(
                    label: 'Confirm Password',
                    hintText: '',
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                ],
              ),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is FailureAuthenticationBySignupState) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: context.mediaQuery.size.height * RATIO_PADDING * 0.2,
                    ),
                    child: DefaultTextStyle.merge(
                      style: context.textTheme.bodyMedium,
                      child: Text(
                        (context.read<AuthenticationBloc>().state
                                as FailureAuthenticationBySignupState)
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
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.mediaQuery.size.height * RATIO_MARGIN * 0.3,
              ),
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is! AuthenticationProgessingState) {
                    return AuthenticatedButton(
                      onPressed: (context) {
                        context.read<AuthenticationBloc>().add(
                              RequestSignupEvent(
                                email: emailController.text,
                                password: passwordController.text,
                                username: usernameController.text,
                                confirmPassword: confirmPasswordController.text,
                              ),
                            );
                        passwordController.clear();
                        confirmPasswordController.clear();
                      },
                      text: 'Create new account',
                    );
                  }
                  return Center(
                    child: SizedBox(
                      width: context.mediaQuery.size.width * 0.1,
                      height: context.mediaQuery.size.width * 0.1,
                      child: CircularProgressIndicator(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  );
                },
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
