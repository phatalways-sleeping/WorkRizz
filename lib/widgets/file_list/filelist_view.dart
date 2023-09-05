import 'package:flutter/material.dart';
import 'file_dbms.dart';
import 'filelist_widget.dart';
class FileListView extends StatefulWidget {
  const FileListView({super.key});

  @override
  State<FileListView> createState() => _FileListViewState();
}

class _FileListViewState extends State<FileListView> {
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child:  SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child: Column(
        //alignment: Alignment.center,
        //color: Color(0xFF2D2F41),
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          
        children: <Widget>[
           Container(
            alignment: Alignment.center,
            child: FileList(),
          ),
          SizedBox(height: 20,), 
         
        ],
      ),
     ), 
    );
  }
}