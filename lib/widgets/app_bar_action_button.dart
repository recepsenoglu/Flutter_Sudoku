import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';

class AppBarActionButton extends StatelessWidget {
  const AppBarActionButton({
    required this.icon,
    required this.onPressed,
    this.iconSize = 26,
    super.key,
  });

  final IconData icon;
  final Function() onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.appBarActions,
      ),
      iconSize: iconSize,
      splashRadius: iconSize,
      visualDensity: VisualDensity.compact,
    );
  }
}
