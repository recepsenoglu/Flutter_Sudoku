import 'package:flutter/material.dart';

class VerticalLines extends StatelessWidget {
  const VerticalLines(
      {required this.borderWidth, required this.borderColor, super.key});

  final double borderWidth;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: double.infinity,
          width: borderWidth,
          color: borderColor,
        ),
        Container(
          height: double.infinity,
          width: borderWidth,
          color: borderColor,
        ),
      ],
    );
  }
}
