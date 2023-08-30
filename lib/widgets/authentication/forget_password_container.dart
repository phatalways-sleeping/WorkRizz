import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/authentication_bloc/authentication_bloc.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';

class ForgetPasswordContainer extends StatefulWidget {
  const ForgetPasswordContainer({super.key});

  @override
  State<ForgetPasswordContainer> createState() =>
      _ForgetPasswordContainerState();
}

class _ForgetPasswordContainerState extends State<ForgetPasswordContainer>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  late final Animation<double> _animation =
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate);

  late final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Container(
        width: double.infinity,
        height: 360.0,
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
                ],
              ),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is FailureForgetPasswordState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      (context.read<AuthenticationBloc>().state
                              as FailureForgetPasswordState)
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
                vertical: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  AuthenticatedButton(
                    onPressed: (contetx) {
                      context.read<AuthenticationBloc>().add(
                            RequestForgetPasswordEvent(
                              email: emailController.text,
                            ),
                          );
                      emailController.clear();
                    },
                    text: 'Send Email',
                  )
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
