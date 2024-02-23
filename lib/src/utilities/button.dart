import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/export.dart';
import '../multi_date_picker.dart';

class Button extends ConsumerStatefulWidget {
  const Button({
    super.key,
    this.style,
    this.onDateSelected,
  });

  final CalendarStyleConfiguration? style;
  final Function(List<DateTime>)? onDateSelected;

  @override
  ConsumerState<Button> createState() => _ButtonState();
}

class _ButtonState extends ConsumerState<Button> {
  late CalendarStyleConfiguration defaultStyle;
  @override
  void initState() {
    defaultStyle = CalendarStyleConfiguration.defaultStyle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyleConfiguration buttonStyle =
        widget.style?.buttonStyleConfiguration ??
            defaultStyle.buttonStyleConfiguration!;
    return Align(
      alignment: const Alignment(0, 0.94),
      child: GestureDetector(
        onTap: () {
          widget.onDateSelected?.call(ref.read(selectionProvider));
        },
        child: Container(
          alignment: Alignment.center,
          height: buttonStyle.height,
          width: buttonStyle.width,
          decoration: buttonStyle.decoration,
          child: buttonStyle.child ??
              Text(
                buttonStyle.buttonText!,
                style: buttonStyle.buttonTextStyle,
              ),
        ),
      ),
    );
  }
}
