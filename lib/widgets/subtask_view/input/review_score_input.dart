import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class TextInput extends StatefulWidget {
  const TextInput({super.key, required this.suffixText, required this.color});
  final String suffixText;
  final Color color;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late final TextEditingController _titleController;
  late final FocusNode _focusNode = FocusNode()..addListener(() {});

  @override
  void initState() {
    _titleController = TextEditingController();
    // _titleController.addListener(() {
    //   if (_titleController.text.isNotEmpty) {
    //     context
    //         .read<ProjectBloc>()
    //         .add(ProjectInputName(_titleController.text));
    //   }
    // });
    // _titleController.text =
    //     (context.read<ProjectBloc>().state as ProjectUserCreateAndSubscribe)
    //         .newProjectSetup
    //         .name;
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
      onTapOutside: (event) {
        // if (_titleController.text.isNotEmpty) {
        //   context
        //       .read<ProjectBloc>()
        //       .add(ProjectInputName(_titleController.text));
        // }
      },
      controller: _titleController,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.start,
      style: context.textTheme.displaySmall?.copyWith(color: widget.color),
      decoration: InputDecoration(
        suffixText: widget.suffixText,
        suffixStyle:
            context.textTheme.displaySmall?.copyWith(color: widget.color),
        // hide the underline of the textformfield when text not empty
        border: InputBorder.none,

        // border: OutlineInputBorder(
        //   borderRadius: const BorderRadius.all(Radius.circular(10)),
        //   borderSide: BorderSide(
        //     color: context.colorScheme.onSecondary,
        //     width: 2.0,
        //   ),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: const BorderRadius.all(Radius.circular(10)),
        //   borderSide: BorderSide(
        //     color: context.colorScheme.onSecondary,
        //     width: 2.0,
        //   ),
        // ),
        focusColor: context.colorScheme.onSecondary,
      ),
    );
  }
}
