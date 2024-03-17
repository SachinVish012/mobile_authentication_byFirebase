import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          child: Container(
            width: 60,
            height: 60,
            color: Colors.grey,
            child: Image.asset(
              'assets/aaa.jpg', // Add your image path here
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
