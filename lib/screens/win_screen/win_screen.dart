import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/enums.dart';
import '../../models/board_model.dart';
import '../../models/cell_model.dart';
import '../../models/game_model.dart';
import '../../services/game_routes.dart';
import '../../utils/exports.dart';
import '../../widgets/button/rounded_button/rounded_button.dart';
import '../../widgets/option_widgets/option_group_widget.dart';
import '../../widgets/sudoku_board/exports.dart';
import '../game_screen/game_screen.dart';
import 'win_screen_provider.dart';

class WinScreen extends StatelessWidget {
  const WinScreen({required this.gameModel, super.key});

  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WinScreenProvider>(
      create: (context) => WinScreenProvider(gameModel),
      child: Consumer<WinScreenProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: GameColors.winScreenBg,
            body: CustomScrollView(
              shrinkWrap: false,
              physics: const PageScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: GameSizes.getHorizontalPadding(0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),
                        Padding(
                          padding: GameSizes.getVerticalPadding(0.02),
                          child: Text(
                            GameStrings.levelCompleted,
                            style: GameTextStyles.winScreenHeader
                                .copyWith(fontSize: GameSizes.getWidth(0.08)),
                          ),
                        ),
                        const Spacer(),
                        MiniSudokuBoard(
                            boardModel: provider.gameModel.sudokuBoard),
                        const Spacer(),
                        LevelStatistics(gameModel: provider.gameModel),
                        NewGameButton(onPressed: () => provider.newGame()),
                        MainButton(
                            onPressed: () =>
                                GameRoutes.goTo(GameRoutes.navigationBar)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton({required this.onPressed, super.key});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: GameSizes.getSymmetricPadding(0.05, 0.015),
      child: TextButton(
        onPressed: onPressed,
        child: Text(GameStrings.main,
            style: GameTextStyles.mainTextButton
                .copyWith(fontSize: GameSizes.getWidth(0.04))),
      ),
    );
  }
}

class NewGameButton extends StatelessWidget {
  const NewGameButton({required this.onPressed, super.key});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: GameSizes.getHeight(0.075),
      child: Padding(
        padding: GameSizes.getHorizontalPadding(0.05),
        child: RoundedButton(
          buttonText: GameStrings.newGame,
          onPressed: onPressed,
          whiteButton: true,
        ),
      ),
    );
  }
}

class LevelStatistics extends StatelessWidget {
  const LevelStatistics({required this.gameModel, super.key});

  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: GameSizes.getPadding(0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(GameStrings.statistics,
                  style: GameTextStyles.levelStatisticsTitle
                      .copyWith(fontSize: GameSizes.getWidth(0.04))),
              InkWell(
                onTap: () =>
                    GameRoutes.goTo(GameRoutes.navigationBar, args: [2]),
                borderRadius: GameSizes.getRadius(16),
                child: Container(
                  padding: GameSizes.getSymmetricPadding(0.02, 0.005),
                  decoration: BoxDecoration(
                      borderRadius: GameSizes.getRadius(16),
                      color: GameColors.translucentWhite),
                  child: Text(GameStrings.seeAll,
                      style: GameTextStyles.seeAll
                          .copyWith(fontSize: GameSizes.getWidth(0.035))),
                ),
              ),
            ],
          ),
        ),
        // PromotionContainer(gameModel: gameModel),
        OptionGroup(
          bgColor: GameColors.translucentWhite,
          dividerColor: Colors.white,
          options: [
            StatRowWidget(
              icon: Icons.bar_chart,
              title: GameStrings.difficulty,
              value: gameModel.difficulty.name,
            ),
            StatRowWidget(
              icon: Icons.stars_rounded,
              title: GameStrings.score,
              value: gameModel.score.toString(),
            ),
            StatRowWidget(
              icon: Icons.timer,
              title: GameStrings.time,
              value: gameModel.time.toInt().toTimeString(),
            ),
          ],
        ),
        SizedBox(height: GameSizes.getHeight(0.02)),
      ],
    );
  }
}

class PromotionContainer extends StatelessWidget {
  const PromotionContainer({
    super.key,
    required this.gameModel,
  });

  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
      decoration: BoxDecoration(
        color: GameColors.translucentWhite,
        borderRadius: BorderRadius.circular(13),
      ),
      // child: PromotionText(
      //   time: gameModel.time,
      //   faster: true,
      //   difficulty: gameModel.difficulty,
      //   newBestTime: newBestTime,
      //   timeDifference: timeDifference,
      // ),
    );
  }
}

class StatRowWidget extends StatelessWidget {
  const StatRowWidget({
    required this.icon,
    required this.title,
    required this.value,
    super.key,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: GameSizes.getSymmetricPadding(0.02, 0.01),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: GameSizes.getWidth(0.07),
          ),
          SizedBox(width: GameSizes.getWidth(0.03)),
          Text(
            title,
            style: GameTextStyles.statRowText
                .copyWith(fontSize: GameSizes.getWidth(0.04)),
          ),
          const Spacer(),
          Text(
            value,
            style: GameTextStyles.statRowText
                .copyWith(fontSize: GameSizes.getWidth(0.04)),
          ),
        ],
      ),
    );
  }
}

class PromotionText extends StatelessWidget {
  const PromotionText({
    super.key,
    required this.time,
    required this.faster,
    required this.difficulty,
    required this.newBestTime,
    required this.timeDifference,
  });

  final int time;
  final bool faster;
  final bool newBestTime;
  final int timeDifference;
  final Difficulty difficulty;

  @override
  Widget build(BuildContext context) {
    if (newBestTime) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: GameStrings.youSetANew,
          style: GameTextStyles.promotionText,
          children: [
            TextSpan(
              text: GameStrings.bestTimeB,
              style: GameTextStyles.promotionTextGold,
            ),
            const TextSpan(
              text: GameStrings.forThe,
            ),
            TextSpan(
              text: difficulty.name,
            ),
            const TextSpan(
              text: GameStrings.difficultyLevel,
            ),
            TextSpan(
              text: time.toTimeString(),
              style: GameTextStyles.promotionTextGold,
            ),
            const TextSpan(
              text: '!',
            ),
          ],
        ),
      );
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: GameStrings.youSolvedThisPuzzle,
        style: GameTextStyles.promotionText,
        children: [
          TextSpan(
            text:
                '${timeDifference.toTimeString()} ${faster ? GameStrings.faster : GameStrings.slower}',
            style: GameTextStyles.promotionTextGold,
          ),
          const TextSpan(
            text: GameStrings.thanYourAverage,
          ),
        ],
      ),
    );
  }
}

class MiniSudokuBoard extends StatelessWidget {
  const MiniSudokuBoard({required this.boardModel, super.key});

  final BoardModel boardModel;

  @override
  Widget build(BuildContext context) {
    final double borderWidth = GameSizes.getWidth(0.004);
    final double cellBorderWidth = GameSizes.getWidth(0.003);

    return Container(
      width: GameSizes.getWidth(0.65),
      height: GameSizes.getWidth(0.65),
      padding: GameSizes.getPadding(0.03),
      margin: GameSizes.getVerticalPadding(0.04),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: GameSizes.getRadius(10)),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: borderWidth)),
        child: Stack(
          children: [
            VerticalLines(
              borderWidth: borderWidth,
              borderColor: GameColors.boardBorder,
            ),
            HorizontalLines(
              borderWidth: borderWidth,
              borderColor: GameColors.boardBorder,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: borderWidth,
                crossAxisSpacing: borderWidth,
              ),
              itemCount: 9,
              itemBuilder: (context, boxIndex) {
                return Stack(
                  children: [
                    VerticalLines(
                      borderWidth: cellBorderWidth,
                      borderColor: GameColors.cellBorder,
                    ),
                    HorizontalLines(
                      borderWidth: cellBorderWidth,
                      borderColor: GameColors.cellBorder,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: cellBorderWidth,
                        crossAxisSpacing: cellBorderWidth,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, boxCellIndex) {
                        CellModel cell = boardModel.getCellByBoxIndex(
                            boxIndex, boxCellIndex);

                        return CellValueText(cell: cell);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
