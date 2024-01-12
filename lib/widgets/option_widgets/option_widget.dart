import 'package:flutter/material.dart';

import '../../utils/game_colors.dart';
import '../../utils/game_sizes.dart';
import '../../utils/game_text_styles.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    required this.title,
    required this.iconData,
    required this.iconColor,
    this.onTap,
    this.loading = false,
    super.key,
  });

  final String title;
  final IconData iconData;
  final Color iconColor;
  final Function()? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTap,
      borderRadius: GameSizes.getRadius(6),
      child: Padding(
        padding: GameSizes.getVerticalPadding(0.005),
        child: Row(
          children: [
            SizedBox(width: GameSizes.getWidth(0.01)),
            Container(
              width: GameSizes.getWidth(0.07),
              height: GameSizes.getWidth(0.07),
              padding: GameSizes.getPadding(0.01),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: GameSizes.getRadius(6),
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
            SizedBox(width: GameSizes.getWidth(0.04)),
            Text(title,
                style: GameTextStyles.optionButtonTitle
                    .copyWith(fontSize: GameSizes.getWidth(0.04))),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              color: GameColors.greyColor,
              size: GameSizes.getWidth(0.07),
            ),
          ],
        ),
      ),
    );
  }
}
