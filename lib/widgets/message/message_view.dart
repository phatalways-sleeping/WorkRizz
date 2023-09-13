import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/assets/svgs/svg_assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/message/message_dbms.dart';
import 'package:task_managing_application/widgets/message/mini_nav.dart';
import 'message_widget.dart';
import 'typing_widget.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    String inputMessage = "";
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      //hideFloatingActionButton: false,
      //hideNavigationBar: true,
      body: CustomScrollView(

        slivers: [
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: CustomHeaderBar(
                upperChild: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: BLACK, size: 20.0),
                bottomChild: Container(
                  margin: EdgeInsets.only(top: screenWidth * RATIO_PADDING),
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(screenWidth * RATIO_PADDING),
                          decoration: BoxDecoration(
                            color: ORANGE,
                            borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                          ),
                          child: SvgPicture.string(
                            SvgAssets.chat,
                            width: 24,
                          )),
                      SizedBox(width: screenWidth * RATIO_PADDING),
                      const Text("Messages"),
                    ],
                  ),
                ),
                onPressed: (context) {}),
          ),
          const SliverToBoxAdapter(
            child: Column(
              children: [
                MiniNavMessage(totalNotes: 1),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Message()),
              ],
            ),
          ),
        ],
      ),

    bottomNavigationBar: Container(
     height: screenHeight * 0.07,
     child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              //color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                      ),
                      onChanged: (text){
                        inputMessage = text;
                      },  
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      MessageManagement().sendMessage(inputMessage, "Vinh");
                    },
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
                
              ),
            ),
          ),
        ],
      ),
    ),

    );
  }
}