import 'package:flutter/material.dart';

extension MaterialStatesExtension on Iterable<MaterialState> {
  bool get isHovered => contains(MaterialState.hovered);
  bool get isFocused => contains(MaterialState.focused);
  bool get isPressed => contains(MaterialState.pressed);
  bool get isSelected => contains(MaterialState.selected);
  bool get isDisabled => contains(MaterialState.disabled);
  bool get isDragged => contains(MaterialState.dragged);
}