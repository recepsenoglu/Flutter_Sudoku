import 'package:flutter/material.dart';
import 'package:flutter_sudoku/models/useful_tip_model.dart';
import 'package:flutter_sudoku/widgets/popup/useful_tip_divider.dart';

import '../../utils/game_colors.dart';
import '../../utils/game_sizes.dart';

class UsefulTipWidget extends StatelessWidget {
  const UsefulTipWidget({super.key, required this.usefulTipModel});

  final UsefulTipModel usefulTipModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UsefulTipDivider(),
        Container(
          width: double.infinity,
          padding: GameSizes.getSymmetricPadding(0.045, 0.03),
          margin: GameSizes.getHorizontalPadding(0.05),
          decoration: BoxDecoration(
              color: GameColors.usefulTipBg, borderRadius: GameSizes.getRadius(12)),
          child: Column(
            children: [
              Icon(
                usefulTipModel.iconData,
                color: usefulTipModel.color,
                size: GameSizes.getWidth(0.1),
              ),
              SizedBox(height: GameSizes.getHeight(0.015)),
              Text(
                usefulTipModel.title,
                style: TextStyle(
                  color: GameColors.usefulTipTitle,
                  fontWeight: FontWeight.bold,
                  fontSize: GameSizes.getWidth(0.045),
                ),
              ),
              SizedBox(height: GameSizes.getHeight(0.015)),
              Text(
                usefulTipModel.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: GameColors.usefulTipContent,
                  fontSize: GameSizes.getWidth(0.035),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
