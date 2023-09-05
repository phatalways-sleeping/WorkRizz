import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/homepage/homepage_view.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    //context.read<HomePageBloc>().add(const HomePageSubscribeToFirestore());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePageView(),
    );
  }
}
