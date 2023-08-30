import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/authentication_bloc/authentication_bloc.dart';


class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.title,
    required this.controller,
    required this.keyboardType,
    this.textAlign = TextAlign.justify,
    this.obscureText = false,
  });

  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textAlign: textAlign,
      style: TextStyle(
        color: context.colorScheme.primary,
        fontFamily: 'Nunito',
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: title,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: context.colorScheme.primary,
            width: 2,
          ),
        ),
        focusColor: context.colorScheme.primary,
        fillColor: context.colorScheme.primary,
      ),
    );
  }
}

class ClickableText extends StatelessWidget {
  const ClickableText({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
  });

  final String text;
  final void Function(BuildContext context) onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : () => onPressed(context),
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          context.colorScheme.background,
        ),
        alignment: Alignment.center,
        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
        overlayColor: MaterialStatePropertyAll(
          context.colorScheme.primary.withOpacity(0.3),
        ),
        animationDuration: const Duration(
          milliseconds: 500,
        ),
        visualDensity: VisualDensity.comfortable,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: context.colorScheme.primary,
          fontFamily: 'Nunito',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class AuthenticatedButton extends StatelessWidget {
  const AuthenticatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final String text;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationBySignInProgressingState ||
            state is AuthenticationBySignUpProgressingState ||
            state is ForgetPasswordProgressingState) {
          return const SizedBox.shrink();
        }
        return ElevatedButton(
          style: ButtonStyle(
            splashFactory: InkRipple.splashFactory,
            shadowColor: MaterialStatePropertyAll(
                context.colorScheme.secondary),
            elevation: const MaterialStatePropertyAll(10.0),
            backgroundColor:
                MaterialStatePropertyAll(context.colorScheme.primary),
            minimumSize: const MaterialStatePropertyAll(Size(330, 50)),
            alignment: Alignment.center,
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          onPressed: () => onPressed(context),
          child: Text(
            text,
            style: TextStyle(
              color: context.colorScheme.background,
              fontFamily: 'Nunito',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
