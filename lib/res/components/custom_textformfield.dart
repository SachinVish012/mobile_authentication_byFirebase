import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final TextInputType keyboardType;
  final String labelText;
  final bool borderEnabled;
  final double height;
  final EdgeInsets margin;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.icon,
    this.keyboardType = TextInputType.text,
    required this.labelText,
    this.borderEnabled = true,
    this.height = 50.0,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.only(left: 30,bottom: 5),
          border: borderEnabled ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.black),
          ) : InputBorder.none,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }
}
