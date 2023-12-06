import 'package:flutter/material.dart';

import '../../utils/game_sizes.dart';
import '../../utils/game_text_styles.dart';

class GameInfoWidget extends StatelessWidget {
  const GameInfoWidget({
    required this.title,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.forPopup = false,
    super.key,
  });

  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;
  final bool forPopup;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: forPopup
                ? GameTextStyles.popupInfoTitle
                    .copyWith(fontSize: GameSizes.getWidth(0.035))
                : GameTextStyles.gameInfoTitle.copyWith(
                    fontSize: GameSizes.getWidth(0.033),
                  ),
          ),
          SizedBox(
              height: forPopup
                  ? GameSizes.getHeight(0.005)
                  : GameSizes.getHeight(0.002)),
          Text(
            value,
            style: forPopup
                ? GameTextStyles.popupInfoValue
                    .copyWith(fontSize: GameSizes.getWidth(0.043))
                : GameTextStyles.gameInfoTitle
                    .copyWith(fontSize: GameSizes.getWidth(0.032)),
          ),
        ],
      ),
    );
  }
}
