import 'package:flutter/material.dart';

import '../../utils/game_colors.dart';
import '../../utils/game_sizes.dart';

class UsefulTipWidget extends StatelessWidget {
  const UsefulTipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: GameSizes.getSymmetricPadding(0.045, 0.03),
      margin: GameSizes.getHorizontalPadding(0.05),
      decoration: BoxDecoration(
          color: GameColors.usefulTipBg, borderRadius: GameSizes.getRadius(12)),
      child: Column(
        children: [
          Icon(
            Icons.stacked_bar_chart,
            color: Colors.blue,
            size: GameSizes.getWidth(0.1),
          ),
          SizedBox(height: GameSizes.getHeight(0.015)),
          Text(
            'Statistics',
            style: TextStyle(
              color: GameColors.usefulTipTitle,
              fontWeight: FontWeight.bold,
              fontSize: GameSizes.getWidth(0.045),
            ),
          ),
          SizedBox(height: GameSizes.getHeight(0.015)),
          Text(
            'Each puzzle solved improves your statistics!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: GameColors.usefulTipContent,
              fontSize: GameSizes.getWidth(0.035),
            ),
          ),
        ],
      ),
    );
  }
}
