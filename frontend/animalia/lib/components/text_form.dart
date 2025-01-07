import 'package:animalia/theme/color_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextForm extends StatelessWidget {
  TextForm(
      {super.key,
      required this.controller,
      required this.hintText,
      this.enabledBorderColor,
      this.focusedBorderColor,
      this.hintColor,
      this.inputColor,
      this.obscureText});
  Color? inputColor;
  bool? obscureText;
  Color? hintColor;
  Color? focusedBorderColor;
  Color? enabledBorderColor;
  TextEditingController controller;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      textAlignVertical: TextAlignVertical.center,
      obscuringCharacter: "x",
      controller: controller,
      cursorHeight: 20,
      cursorRadius: const Radius.circular(5),
      cursorOpacityAnimates: true,
      style: TextStyle(
        color: inputColor ?? artichoke,
        fontSize: 18,
      ),
      cursorColor: inputColor ?? artichoke,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: enabledBorderColor ?? camoGreen, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: focusedBorderColor ?? darkJungleGreen, width: 2)),
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor ?? artichoke,
            fontSize: 18,
          )),
    );
  }
}
