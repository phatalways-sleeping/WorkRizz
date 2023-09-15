import 'package:flutter/material.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'messages_demo.dart';
class ChatbotView extends StatefulWidget {
  const ChatbotView({super.key});

  @override
  State<ChatbotView> createState() => _ChatbotViewState();
}

class _ChatbotViewState extends State<ChatbotView> {
  //late final ScrollController _scrollController;
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideFloatingActionButton: true,
      hideNavigationBar: true,
      child: Column(
        children: [
          Expanded(child: MessagesScreen(messages: messages)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: Colors.deepPurple,
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                )),
                IconButton(
                    onPressed: () async{
                      sendMessage(_controller.text);
                      
                      _controller.clear();
                      
                     /*  SchedulerBinding.instance?.addPostFrameCallback((_) {
                        _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.fastOutSlowIn);
                      }); */
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
     
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
