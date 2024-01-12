import 'package:flutter/material.dart';

import '../../../utils/game_colors.dart';
import '../../../utils/game_sizes.dart';

class HintsAmountCircle extends StatelessWidget {
  const HintsAmountCircle({required this.hints, super.key});

  final int hints;

  @override
  Widget build(BuildContext context) {
    String hintText = hints.toString();

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
