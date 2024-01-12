import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';
import 'package:flutter_sudoku/utils/game_text_styles.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.optionsBackground,
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: GameColors.appBarBackground,
        title: Text(
          "rules".tr(),
          style: GameTextStyles.optionsScreenAppBarTitle
              .copyWith(fontSize: GameSizes.getWidth(0.045)),
        ),
      ),
      body: SingleChildScrollView(
        padding: GameSizes.getSymmetricPadding(0.04, 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "sudokuRules".tr(),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: GameSizes.getWidth(0.05),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              "sudokuRulesTexts".tr(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Icon(
              Icons.circle,
              size: GameSizes.getWidth(0.025),
              color: Colors.black,
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              "tipsOnSolvingSudokuPuzzles".tr(),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: GameSizes.getWidth(0.05),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              "tipsOnSolvingSudokuPuzzlesTexts".tr(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
