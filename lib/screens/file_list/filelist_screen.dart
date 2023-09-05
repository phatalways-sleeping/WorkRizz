import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/file_list/filelist_view.dart';
class FileListScreen extends StatefulWidget {
  const FileListScreen({Key? key}) : super(key: key);

  @override
  State<FileListScreen> createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  @override
  void initState() {
    //context.read<FileListBloc>().add(const FileListSubscribeToFirestore());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FileListView(),
    );
  }
}
