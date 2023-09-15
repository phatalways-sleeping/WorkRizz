import 'package:flutter/material.dart';
import 'package:task_managing_application/apis/pdf/pdf_api.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/tasklist/custom_button.dart';

class ExportReportOverlay extends StatelessWidget {
  const ExportReportOverlay({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          constraints: BoxConstraints.loose(
            Size(
              context.mediaQuery.size.width * 0.5,
              context.mediaQuery.size.height * 0.06,
            ),
          ),
          margin: EdgeInsets.only(
            top: context.mediaQuery.size.height * 0.15,
            right: context.mediaQuery.size.width * RATIO_PADDING + 16.0,
          ),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: CustomButton(
            name: 'Export as PDF',
            onPressed: (context) async => await PdfAPI.buildReport(
              projectId,
            ).then(
              (value) {
                context.scaffoldMessenger.removeCurrentSnackBar();
                context
                    .read<NavigationBloc>()
                    .add(NavigateToPDFReportViewer(value));
              },
            ),
            message: 'Exporting report as PDF...',
          ),
        ),
      ),
    );
  }
}
