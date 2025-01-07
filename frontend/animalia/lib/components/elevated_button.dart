import 'package:animalia/theme/color_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {super.key,
      this.text,
      this.backgroundColor,
      this.borderRadius,
      this.height,
      this.textColor,
      this.width,
      required this.onpressed,
      this.overlayColor,
      this.child});
  Color? backgroundColor;
  Color? textColor;
  String? text;
  double? width;
  double? height;
  double? borderRadius;
  Widget? child;
  Color? overlayColor;
  Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      autofocus: true,
      onPressed: onpressed,
      style: ButtonStyle(
          overlayColor:
              WidgetStateProperty.all(overlayColor ?? darkJungleGreen),
          tapTargetSize: MaterialTapTargetSize.padded,
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10))),
          padding: WidgetStateProperty.all(const EdgeInsets.all(5)),
          backgroundColor:
              WidgetStateProperty.all(backgroundColor ?? darkJungleGreen),
          fixedSize:
              WidgetStateProperty.all(Size(width ?? 1000, height ?? 60))),
      child: child ??
          Text(
            text ?? "Button",
            style: TextStyle(color: textColor ?? artichoke, fontSize: 16),
          ),
    );
  }
}
