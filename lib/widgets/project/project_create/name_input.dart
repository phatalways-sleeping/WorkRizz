import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/states/states.dart';

class NameInput extends StatefulWidget {
  const NameInput({super.key});

  @override
  State<NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  late final TextEditingController _titleController = TextEditingController();
  late final FocusNode _focusNode = FocusNode()..addListener(() {});
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
        if (_titleController.text.isNotEmpty) {
          context
              .read<ProjectBloc>()
              .add(ProjectInputName(_titleController.text));
        }
      },
      controller: _titleController,
      keyboardType: TextInputType.name,
      obscureText: false,
      textAlign: TextAlign.start,
      style: context.textTheme.bodyMedium?.copyWith(
        color: context.colorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: "Title",
        hintText: "What is your project name?",
        labelStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.4,
          horizontal: context.mediaQuery.size.width * RATIO_PADDING * 0.4,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: context.colorScheme.onSecondary,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: context.colorScheme.onSecondary,
            width: 2.0,
          ),
        ),
        focusColor: context.colorScheme.onSecondary,
      ),
    );
  }
}
