import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/authentication_bloc/authentication_bloc.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.label,
    this.hintText = '',
    required this.controller,
    required this.keyboardType,
    this.textAlign = TextAlign.justify,
    this.obscureText = false,
  });

  final String label;
  final String hintText;
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
      style: context.textTheme.bodyMedium!.copyWith(
        color: context.colorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorScheme.onSurface,
        ),
        hintStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorScheme.onSurface,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.4,
          horizontal: context.mediaQuery.size.width * RATIO_PADDING * 0.4,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: context.colorScheme.onSecondary,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: context.colorScheme.onSecondary,
            width: 1.5,
          ),
        ),
        focusColor: context.colorScheme.onSecondary,
        fillColor: context.colorScheme.onSecondary,
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
    return InkWell(
      onTap: disabled ? null : () => onPressed(context),
      child: DefaultTextStyle.merge(
        style: context.textTheme.bodySmall,
        child: Text(
          text,
          style: TextStyle(
            color: context.colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
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
            elevation: const MaterialStatePropertyAll(1.0),
            backgroundColor: MaterialStatePropertyAll(
              context.colorScheme.onSecondary,
            ),
            minimumSize: MaterialStatePropertyAll(
              Size(context.mediaQuery.size.width * 0.9, 50),
            ),
            alignment: Alignment.center,
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: context.mediaQuery.size.width * RATIO_PADDING * 0.5,
                vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.3,
              ),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          onPressed: () => onPressed(context),
          child: DefaultTextStyle.merge(
            style: context.textTheme.bodyLarge,
            child: Text(
              text,
              style: TextStyle(
                color: context.colorScheme.onBackground,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
