import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_nav_bar/custom_route_button.dart';
import 'package:task_managing_application/widgets/widgets.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
    this.hideRouteButtons = false,
  });

  final bool hideRouteButtons;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(
        Size(
          context.mediaQuery.size.width,
          context.mediaQuery.size.height * 0.1,
        ),
      ),
      margin: EdgeInsets.only(
        left: context.mediaQuery.size.width * RATIO_MARGIN,
        right: context.mediaQuery.size.width * RATIO_MARGIN,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!widget.hideRouteButtons) ...[
                  CustomRouteButton(
                    icon: SvgAssets.home,
                    onPressed: (context) => context
                        .read<NavigationBloc>()
                        .add(const NavigateToHome()),
                    route: 'Home',
                    chosen: state is Home,
                  ),
                  CustomRouteButton(
                    icon: SvgAssets.projectsList,
                    onPressed: (context) => context
                        .read<NavigationBloc>()
                        .add(const NavigateToProjectsList()),
                    route: 'Projects',
                    chosen: state is ProjectsList,
                  ),
                  CustomRouteButton(
                    icon: SvgAssets.assistant,
                    onPressed: (context) => context
                        .read<NavigationBloc>()
                        .add(const NavigateToAssistant()),
                    route: 'Assistant',
                    chosen: state is Assistant,
                  )
                ],
                const Spacer(),
                const CustomFloatingWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
