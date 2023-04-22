import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';

class AppBarActionButton extends StatelessWidget {
  const AppBarActionButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.appBarActions,
      ),
      iconSize: 28,
      splashRadius: 26,
      visualDensity: VisualDensity.compact,
    );
  }
}
