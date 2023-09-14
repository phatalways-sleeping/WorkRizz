import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/assets/utils/functions.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/home_bloc/home_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/home/activity_widget.dart';
import 'package:task_managing_application/widgets/widgets.dart';
import 'date_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController = ScrollController()
    ..addListener(() {});

  get separatorBuilder => null;

  get amount => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideNavigationBar: false,
      hideFloatingActionButton: true,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial || state is HomeLoading) {
            return const Center(child: CustomCircularProgressIndicator());
          }
          if (state is HomeError) {
            return Center(
              child: Column(
                children: [
                  const Text("Error has occured"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(const HomeSubscribeEvent());
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(PALE),
                    ),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }
          final username = (state as HomeSuccess).username;
          final subTaskIds = (state).subTaskIds;
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomHeaderBar(
                  upperChild: Text("Hello $username"),
                  bottomChild: Text(
                    "Today's ${convertWeekdayToString(DateTime.now().weekday)}",
                  ),
                  onPressed: (context) {},
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const DateCapsule(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ActivityWidget(
                        subTaskIds: subTaskIds,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
