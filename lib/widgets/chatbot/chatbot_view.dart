import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/states.dart'
    show NavigateToTask, NavigationBloc, ReadContext;
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/message/message_keyboard.dart';
import 'chatbot_scroll_view.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';
class ChatbotView extends StatefulWidget {
  const ChatbotView({super.key});

  @override
  State<ChatbotView> createState() => _ChatbotViewState();
}

class _ChatbotViewState extends State<ChatbotView> {
  late final ScrollController _scrollController;
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  
  List<Map<String, dynamic>> messages = [];


  @override
  void initState() {
    //_scrollController = ScrollController();
    
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //hideFloatingActionButton: true,
      //hideNavigationBar: true,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: context.mediaQuery.size.height * 0.10,
                child: CustomScrollView(
                  //controller: _scrollController,
                  slivers: [
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: CustomHeaderBar(
                        atHomePage: false,
                        hideAvatar: true,
                        trailing: const SizedBox.shrink(),
                        upperChild: const SizedBox.shrink(),
                        bottomChild: Container(
                          margin: EdgeInsets.only(
                            top: context.mediaQuery.size.width * RATIO_PADDING,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  context.mediaQuery.size.width * RATIO_PADDING,
                                ),
                                decoration: BoxDecoration(
                                  color: ORANGE,
                                  borderRadius:
                                      BorderRadius.circular(MEDIUM_CORNER),
                                ),
                                child: SvgPicture.string(
                                  SvgAssets.chat,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              SizedBox(
                                width: context.mediaQuery.size.width *
                                    RATIO_PADDING,
                              ),
                              const Text(
                                "Chatbots",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: (context) =>
                            context.read<NavigationBloc>().add(
                                  const NavigateToTask(
                                    projectId: null,
                                    leaderId: null,
                                    projectName: null,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Expanded(child: ChatbotScrollView(messages: messages,),),
            ],
          ),
          Align( // keyboard
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
                      controller: _controller,
                      showLabel: false,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
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
