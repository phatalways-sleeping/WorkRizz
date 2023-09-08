import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';

class ScoreInput extends StatefulWidget {
  const ScoreInput({
    super.key,
    required this.listener,
    required this.initialValue,
  });

  final void Function(BuildContext context, TextEditingController controller)
      listener;
  final String initialValue;

  @override
  State<ScoreInput> createState() => _ScoreInputState();
}

class _ScoreInputState extends State<ScoreInput> {
  late final TextEditingController _titleController;
  late final FocusNode _focusNode = FocusNode()..addListener(() {});

  @override
  void initState() {
    _titleController = TextEditingController();
    
    _titleController.text = widget.initialValue;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 10,
      focusNode: _focusNode,
      controller: _titleController,
      onChanged: (value) => widget.listener(context, _titleController),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.start,
      style: context.textTheme.bodyMedium?.copyWith(
        color: context.colorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
            SvgPicture.string(
              SvgAssets.note,
              colorFilter: const ColorFilter.mode(PINK, BlendMode.srcIn),
            ),
            SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
          ],
        ),
        suffixText: 'pt',
        suffixStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: context.textTheme.titleMedium,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.mediaQuery.size.width * RATIO_PADDING * 1.2,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(MEDIUM_CORNER)),
          borderSide: BorderSide(
            color: BLACK,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(MEDIUM_CORNER)),
          borderSide: BorderSide(
            color: BLACK,
            width: 1.0,
          ),
        ),
        focusColor: context.colorScheme.onSecondary,
      ),
    );
  }
}
