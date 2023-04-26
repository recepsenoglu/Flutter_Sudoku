import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';

class ActionIcon extends StatelessWidget {
  const ActionIcon(
    this.iconData, {
    this.rightPadding = 0,
    super.key,
  });

  final IconData iconData;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6, right: rightPadding),
      child: Icon(
        iconData,
        color: AppColors.actionButton,
        size: 36,
      ),
    );
  }
}
