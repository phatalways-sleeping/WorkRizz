import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/tasklist/export_report_overlay.dart';

class OtherOptionsButton extends StatefulWidget {
  const OtherOptionsButton({
    super.key,
    required this.projectId,
    this.isLeader = true,
  });
  final String projectId;
  final bool isLeader;

  @override
  State<OtherOptionsButton> createState() => _OtherOptionsButtonState();
}

class _OtherOptionsButtonState extends State<OtherOptionsButton> {
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
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ExportReportOverlay(
            projectId: widget.projectId,
          ),
        ],
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
        minimumSize: const MaterialStatePropertyAll(
          Size(
            24.0,
            24.0,
          ),
        ),
        maximumSize: const MaterialStatePropertyAll(
          Size(
            24.0,
            24.0,
          ),
        ),
        iconSize: MaterialStateProperty.all(
          24.0,
        ),
        alignment: Alignment.centerRight,
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
