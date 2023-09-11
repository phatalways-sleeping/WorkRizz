import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/file_list/filelist_view.dart';
class FileListScreen extends StatelessWidget {
  const FileListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FileListView(),
    );
  }
}
