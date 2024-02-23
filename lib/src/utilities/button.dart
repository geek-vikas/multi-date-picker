import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
    this.radius = 10.0,
    this.padding,
    this.width,
    this.height,
    this.textStyle,
    this.shadowColor,
  });

  final VoidCallback? onTap;
  final Color? color;
  final String text;
  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: shadowColor != null
              ? <BoxShadow>[
                  BoxShadow(
                    color: (shadowColor ?? Colors.grey).withOpacity(0.5),
                    spreadRadius: -5.0,
                    blurRadius: 10.0,
                    offset: const Offset(0, 5.0),
                  )
                ]
              : null,
        ),
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: padding,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0XFF252B5C),
              fontFamily: 'DMSans',
            ),
          ),
        ),
      ),
    );
  }
}
