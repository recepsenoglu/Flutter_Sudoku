import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';
import 'package:flutter_sudoku/utils/game_text_styles.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.title,
    required this.iconWidget,
    required this.onTap,
    super.key,
  });

  final String title;
  final Widget iconWidget;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: GameSizes.getRadius(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            iconWidget,
            SizedBox(height: GameSizes.getHeight(0.005)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GameTextStyles.actionButton
                  .copyWith(fontSize: GameSizes.getWidth(0.035)),
            )
          ],
        ),
      ),
    );
  }
}
