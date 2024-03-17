import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double height;
  final double width;

  CustomElevatedButton({
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.height=50,
    this.width=double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: backgroundColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white, // You can adjust text color here
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
