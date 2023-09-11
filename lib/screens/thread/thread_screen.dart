import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/thread/thread_view.dart';
class ThreadScreen extends StatefulWidget {
  const ThreadScreen({Key? key}) : super(key: key);

  @override
  State<ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<ThreadScreen> {
  @override
  void initState() {
    //context.read<ThreadBloc>().add(const ThreadSubscribeToFirestore());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ThreadView(),
    );
  }
}