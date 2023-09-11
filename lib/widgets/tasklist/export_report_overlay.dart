import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_managing_application/apis/pdf/pdf_api.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_download_snackbar.dart';

class ExportReportOverlay extends StatefulWidget {
  const ExportReportOverlay({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  State<ExportReportOverlay> createState() => _ExportReportOverlayState();
}

class _ExportReportOverlayState extends State<ExportReportOverlay> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                name: 'Export as PDF',
                onPressed: (context) async => await PdfAPI.buildReport(
                  widget.projectId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.name,
    required this.onPressed,
  });

  final String name;
  final Future<File> Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        context.scaffoldMessenger.showSnackBar(
          customDownloadSnackBar(
            context: context,
            message: 'Exporting...',
            duration: const Duration(seconds: 15),
          ),
        );
        await onPressed(context).then(
          (value) {
            context.scaffoldMessenger.removeCurrentSnackBar();
            context
                .read<NavigationBloc>()
                .add(NavigateToPDFReportViewer(value));
          },
        );
      },
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(
          Size(
            context.mediaQuery.size.width * 0.36,
            context.mediaQuery.size.height * 0.03,
          ),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 16.0,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        overlayColor: const MaterialStatePropertyAll(
          GREEN,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.isPressed) {
              return WHITE;
            }
            return BLACK;
          },
        ),
        backgroundColor: const MaterialStatePropertyAll(
          WHITE,
        ),
        splashFactory: InkRipple.splashFactory,
        visualDensity: VisualDensity.comfortable,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: const MaterialStatePropertyAll(0.0),
        shadowColor: const MaterialStatePropertyAll(
          Colors.transparent,
        ),
        side: MaterialStateProperty.resolveWith(
          (states) {
            if (states.isPressed) {
              return const BorderSide(
                color: GREEN,
                width: 2.0,
              );
            }
            return const BorderSide(
              color: BLACK,
              width: 2.0,
            );
          },
        ),
      ),
      child: Text(
        name,
      ),
    );
  }
}
