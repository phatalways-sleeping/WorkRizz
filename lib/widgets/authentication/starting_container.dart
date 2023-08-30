import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/authentication_bloc/authentication_bloc.dart';

class StartingContainer extends StatefulWidget {
  const StartingContainer({super.key});

  @override
  State<StartingContainer> createState() => _StartingContainerState();
}

class _StartingContainerState extends State<StartingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.mediaQuery.size.height * 0.20,
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
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              splashFactory: InkRipple.splashFactory,
              shadowColor: context.colorScheme.onSecondary,
              elevation: 2,
              backgroundColor: context.colorScheme.onSecondary,
              minimumSize: Size(context.mediaQuery.size.width * 0.9, 50),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: context.mediaQuery.size.width * RATIO_PADDING * 0.5,
                vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.3,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            onPressed: () => context.read<AuthenticationBloc>().add(
                  const LoginEvent(),
                ),
            child: Text(
              'Get Started',
              style: TextStyle(
                color: context.colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
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
            height: context.mediaQuery.size.height * RATIO_MARGIN * 0.24,
          ),
        ],
      ),
    );
  }
}
