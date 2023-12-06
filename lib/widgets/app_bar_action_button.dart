import 'package:flutter/material.dart';

import '../utils/game_colors.dart';
import '../utils/game_sizes.dart';

class AppBarActionButton extends StatelessWidget {
  const AppBarActionButton({
    required this.icon,
    required this.onPressed,
    this.iconSize,
    super.key,
  });

  final IconData icon;
  final Function() onPressed;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: GameColors.appBarActions,
      ),
      iconSize: iconSize ?? GameSizes.getHeight(0.035),
      splashRadius: iconSize,
      visualDensity: VisualDensity.compact,
    );
  }
}
