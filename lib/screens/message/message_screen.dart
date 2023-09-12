import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/message/message_view.dart';
class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    //context.read<MessageBloc>().add(const MessageSubscribeToFirestore());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MessageView(),
    );
  }
}