import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';

class ActionIcon extends StatelessWidget {
  const ActionIcon(this.iconData, {super.key});

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: GameSizes.getWidth(0.03)),
        child: Icon(
          iconData,
          color: GameColors.actionButton,
          size: GameSizes.getWidth(0.1),
        ),
      ),
    );
  }
}
