import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';

class PDFReportViewerScreen extends StatelessWidget {
  const PDFReportViewerScreen({
    super.key,
    required this.file,
  });

  final File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: BaseScreen(
        hideNavigationBar: true,
        hideFloatingActionButton: true,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomHeaderBar(
                atHomePage: false,
                hideAvatar: true,
                upperChild: Text(
                  'Project Report',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: BLACK,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                bottomChild: const SizedBox.shrink(),
                onPressed: (context) => context.read<NavigationBloc>().add(
                      const NavigateToTask(
                        projectId: null,
                        leaderId: null,
                        projectName: null,
                      ),
                    ),
                trailing: const SizedBox.shrink(),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 8.0,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: context.mediaQuery.size.width,
                    maxHeight: context.mediaQuery.size.height * 0.8,
                  ),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      side: BorderSide(
                        color: BLACK.withOpacity(0.25),
                        width: 1.0,
                      ),
                    ),
                    color: WHITE,
                  ),
                  child: PDFView(
                    filePath: file.path,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: true,
                    onPageError: (page, error) =>
                        debugPrint('$page: ${error.toString()}'),
                    onRender: (pages) => debugPrint('$pages'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
