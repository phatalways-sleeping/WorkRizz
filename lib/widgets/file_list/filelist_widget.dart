import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'dart:math';
import 'dart:math' as math;
import 'file_dbms.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/assets/fonts/base_font.dart';

class FileList extends StatefulWidget {
  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  @override
  double width = 0.0;
  double height = 0.0;
  ScrollController? scrollController;
  TextEditingController controller = TextEditingController();
  
  var fileManagement = FileManagement();
  List <FileStructure> fileList = [];
   @override
  void initState() {
    fileList = fileManagement.getFiles();
    scrollController =
        ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }
  
  @override
  Widget FileScroll(int index){
    bool newProject = false;
    if (index == 0 || fileList[index].originProject != fileList[index - 1].originProject)
      newProject = true;
    else
      newProject = false;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            // download
          });
        },
        child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (DismissDirection direction) {
              setState(() {
              fileList.removeAt(index);
                
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            if (newProject)
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 35,
                decoration: BoxDecoration(
                  color: fileList[index].color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  fileList[index].originProject,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                  )
                ),
              ),
              if (newProject) SizedBox(height: 20,),
              Container(
                width: width,
                height: 50,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF000000)),
                    gradient: LinearGradient(
                        colors: [Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                        stops: const [0.0, 0.5, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
                        //offset: Offset(4, 4),
                        //blurRadius: 4,
                        //spreadRadius: 2,
                        color: Colors.black12,
                      )
                    ]),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.string(
                        SvgAssets.file,
                        colorFilter: ColorFilter.mode(
                            fileList[index].color, BlendMode.srcIn),
                      ), 
                      SizedBox(width: 10,),
                      Text(
                        fileList[index].name + '.' + fileList[index].type,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        )
                      ),
                      SizedBox(width: width * 0.23,),
                      Image.asset(
                        fileList[index].avatarImage,
                        width: 20,
                        height: 20,
                      ),
                      
                      SizedBox(width: 10,),
                      Text(
                        (-fileList[index].date.difference(DateTime.now()).inMinutes).toString() + ' min ago',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ],
            ),
        ),
      ));
  }

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      child: 
        ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: fileList.length,
          itemBuilder: (BuildContext context, int index) {
            return FileScroll(index);
          },
        ),
      );
  }
}