import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';
import 'package:flutter_sudoku/utils/game_strings.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';

class HintsAmountCircle extends StatelessWidget {
  const HintsAmountCircle({required this.hints, super.key});

  final int hints;

  @override
  Widget build(BuildContext context) {
    String hintText = hints > 0 ? hints.toString() : GameStrings.ad;

    return Positioned(
      right: GameSizes.getWidth(0.02),
      child: Visibility(
        visible: hints > 0,
        child: Container(
          width: GameSizes.getWidth(0.12),
          padding: GameSizes.getPadding(0.005),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Container(
            padding: GameSizes.getPadding(0.003),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: GameColors.actionInfoBg,
            ),
            child: Center(
              child: Text(
                hintText,
                style: TextStyle(
                  color: GameColors.actionInfoText,
                  fontWeight: FontWeight.w600,
                  fontSize: GameSizes.getWidth(0.04),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
