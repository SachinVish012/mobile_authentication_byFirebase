import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomTextWidget({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
