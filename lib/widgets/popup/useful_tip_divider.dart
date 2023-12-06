import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_strings.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_text_styles.dart';

class UsefulTipDivider extends StatelessWidget {
  const UsefulTipDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: GameColors.divider,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            GameStrings.usefulTip,
            style: GameTextStyles.dividerText,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: GameColors.divider,
          ),
        ),
      ],
    );
  }
}
