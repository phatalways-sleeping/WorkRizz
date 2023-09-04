import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/splash_cubit/splash_cubit.dart';
import 'package:task_managing_application/states/states.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<SplashCubit>().moveToLoadingState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/background.jpg",
          height: context.mediaQuery.size.height,
          width: context.mediaQuery.size.width,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.srcATop,
        ),
        BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            if (state is SplashInitial) {
              return const SizedBox.shrink();
            }
            return Positioned(
              bottom: context.mediaQuery.size.height * 0.40,
              child: SizedBox(
                width: context.mediaQuery.size.width * 0.1,
                height: context.mediaQuery.size.width * 0.1,
                child: CircularProgressIndicator(
                  color: context.colorScheme.secondary,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
