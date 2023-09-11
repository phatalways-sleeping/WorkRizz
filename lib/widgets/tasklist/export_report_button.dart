import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/tasklist/export_report_overlay.dart';

class ExportReportButton extends StatefulWidget {
  const ExportReportButton({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  State<ExportReportButton> createState() => _ExportReportButtonState();
}

class _ExportReportButtonState extends State<ExportReportButton> {
  OverlayEntry? _overlayEntry;
  bool isOverlayVisible = false;

  void insertOverlay(BuildContext context) {
    if (isOverlayVisible) {
      setState(() {
        removeOverlay();
        isOverlayVisible = false;
      });
      return;
    }
    removeOverlay();
    _overlayEntry = OverlayEntry(
      builder: (context) => ExportReportOverlay(
        projectId: widget.projectId,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
    setState(
      () {
        isOverlayVisible = true;
      },
    );
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () => insertOverlay(context),
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(WHITE),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        splashFactory: NoSplash.splashFactory,
        fixedSize: MaterialStatePropertyAll(
          Size(
            context.mediaQuery.size.width * RATIO_PADDING * 2,
            context.mediaQuery.size.width * RATIO_PADDING * 2,
          ),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.zero,
        ),
        elevation: const MaterialStatePropertyAll<double>(0.0),
      ),
      icon: SvgPicture.string(
        SvgAssets.tdot,
        width: 5,
        height: 5,
        colorFilter: const ColorFilter.mode(
          BLACK,
          BlendMode.srcATop,
        ),
      ),
    );
  }
}
