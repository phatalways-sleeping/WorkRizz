import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.suffixText,
    required this.color,
    required this.initialNumber,
    required this.listener,
  });
  final String suffixText;
  final Color color;
  final int? initialNumber;
  final void Function(BuildContext context, TextEditingController controller)
      listener;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late final TextEditingController _titleController;
  late final FocusNode _focusNode = FocusNode()..addListener(() {});

  @override
  void initState() {
    _titleController = TextEditingController();
    _titleController
        .addListener(() => widget.listener(context, _titleController));
    _titleController.text = widget.initialNumber?.toString() ?? '';
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
      focusNode: _focusNode,
      controller: _titleController,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.start,
      style: context.textTheme.displaySmall?.copyWith(
        color: widget.color,
        fontSize: 40.0,
      ),
      decoration: InputDecoration(
        suffixText: widget.suffixText,
        suffixStyle: context.textTheme.displaySmall?.copyWith(
          color: widget.color,
          fontSize: 40.0,
        ),
        // hide the underline of the textformfield when text not empty
        border: InputBorder.none,
        focusColor: context.colorScheme.onSecondary,
      ),
    );
  }
}
