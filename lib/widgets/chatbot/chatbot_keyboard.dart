import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/message_bloc/message_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';

class ChatbotKeyboardWidget extends StatefulWidget {
  const ChatbotKeyboardWidget({super.key});

  @override
  State<ChatbotKeyboardWidget> createState() => _ChatbotKeyboardWidgetState();
}

class _ChatbotKeyboardWidgetState extends State<ChatbotKeyboardWidget> {
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
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: BLACK,
              ),
              child: const Icon(
                Icons.add,
                color: WHITE,
                size: 24.0,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: CustomInputField(
                label: "Type a message",
                controller: controller,
                showLabel: false,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () {
                
                controller.clear();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: BLACK,
              ),
              child: const Icon(
                Icons.send,
                color: WHITE,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
