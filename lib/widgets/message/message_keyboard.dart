import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/message_bloc/message_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';

class MessageKeyboardWidget extends StatefulWidget {
  const MessageKeyboardWidget({super.key});

  @override
  State<MessageKeyboardWidget> createState() => _MessageKeyboardWidgetState();
}

class _MessageKeyboardWidgetState extends State<MessageKeyboardWidget> {
  late final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: context.mediaQuery.size.height * 0.08,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          bottom: context.mediaQuery.viewInsets.bottom,
        ),
        padding: EdgeInsets.all(
          context.mediaQuery.size.width * RATIO_PADDING,
        ),
        decoration: const BoxDecoration(
          color: WHITE,
          border: Border(
            top: BorderSide(
              color: BLACK,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: GREEN,
                size: 24.0,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: CustomInputField(
                label: "Message",
                controller: controller,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton(
              onPressed: () {
                context.read<MessageBloc>().add(
                      SendTextMessage(controller.text),
                    );
                controller.clear();
              },
              icon: const Icon(
                Icons.send,
                color: GREEN,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
