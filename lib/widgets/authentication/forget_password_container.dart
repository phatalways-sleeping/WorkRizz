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
        height: context.mediaQuery.size.height * 0.3,
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
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_MARGIN * 0.3,
            ),
            Form(
              child: CustomInputField(
                label: 'Email',
                hintText: 'This email will receive reset password notification',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is FailureForgetPasswordState) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: context.mediaQuery.size.height * RATIO_PADDING * 0.2,
                    ),
                    child: DefaultTextStyle.merge(
                      style: context.textTheme.bodyMedium,
                      child: Text(
                        (context.read<AuthenticationBloc>().state
                                as FailureForgetPasswordState)
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
                  if (state is! ForgetPasswordProgressingState) {
                    return AuthenticatedButton(
                      onPressed: (contetx) {
                        context.read<AuthenticationBloc>().add(
                              RequestForgetPasswordEvent(
                                email: emailController.text,
                              ),
                            );
                        emailController.clear();
                      },
                      text: 'Send Email',
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
