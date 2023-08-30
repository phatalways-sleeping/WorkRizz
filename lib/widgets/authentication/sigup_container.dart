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
        height: 520.0,
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
              'Sign Up',
              style: TextStyle(
                color: context.colorScheme.primary,
                fontFamily: 'Nunito',
                fontSize: 24,
                fontWeight: FontWeight.w700,
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
                  CustomInputField(
                    title: 'Confirm Password',
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    title: 'Username',
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is FailureAuthenticationBySignupState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      (context.read<AuthenticationBloc>().state
                              as FailureAuthenticationBySignupState)
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.read<AuthenticationBloc>().add(
                          const LoginEvent(),
                        ),
                    style: ButtonStyle(
                      animationDuration: const Duration(milliseconds: 100),
                      visualDensity: VisualDensity.comfortable,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.all(10.0),
                      ),
                      overlayColor: MaterialStatePropertyAll(
                        context.colorScheme.primary.withOpacity(0.3),
                      ),
                      shape: MaterialStatePropertyAll(
                        CircleBorder(
                          side: BorderSide(
                            color: context.colorScheme.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        context.colorScheme.primary,
                      ),
                      alignment: Alignment.center,
                    ),
                    child: SizedBox(
                      child: Icon(
                        Icons.navigate_before_rounded,
                        size: 35.0,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (contetx, state) {
                    if (state is! AuthenticationProgessingState) {
                      return const SizedBox.shrink();
                    }

                    return Center(
                      child: CircularProgressIndicator(
                        color: context.colorScheme.primary,
                      ),
                    );
                  }),
                  Expanded(
                    child: AuthenticatedButton(
                      onPressed: (context) {
                        context.read<AuthenticationBloc>().add(
                              RequestSignupEvent(
                                email: emailController.text,
                                password: passwordController.text,
                                username: usernameController.text,
                                confirmPassword: confirmPasswordController.text,
                              ),
                            );
                        emailController.clear();
                        passwordController.clear();
                        confirmPasswordController.clear();
                        usernameController.clear();
                      },
                      text: 'Create new account',
                    ),
                  ),
                ],
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
