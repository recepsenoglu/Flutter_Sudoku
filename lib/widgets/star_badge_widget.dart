import 'package:flutter/material.dart';

class StarBadgeWidget extends StatelessWidget {
  const StarBadgeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Colors.orange.shade300,
      child: Icon(
        Icons.star,
        size: 14,
        color: Colors.orange.shade800,
      ),
    );
  }
}
