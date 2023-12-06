import 'package:flutter/material.dart';

class HorizontalLines extends StatelessWidget {
  const HorizontalLines(
      {super.key, required this.borderWidth, required this.borderColor});

  final double borderWidth;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: double.infinity,
          height: borderWidth,
          color: borderColor,
        ),
        Container(
          width: double.infinity,
          height: borderWidth,
          color: borderColor,
        ),
      ],
    );
  }
}
