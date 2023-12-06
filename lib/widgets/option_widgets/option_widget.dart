import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_text_styles.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    required this.title,
    required this.iconData,
    required this.iconColor,
    this.onTap,
    super.key,
  });

  final String title;
  final IconData iconData;
  final Color iconColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            const SizedBox(width: 4),
            Container(
              width: 28,
              height: 28,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: FittedBox(
                  child: Icon(
                    iconData,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 18),
            Text(
              title,
              style: GameTextStyles.optionButtonTitle,
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              color: GameColors.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
