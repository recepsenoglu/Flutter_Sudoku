import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/models/board_model.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/models/game_model.dart';
import 'package:flutter_sudoku/screens/game_screen/game_screen.dart';
import 'package:flutter_sudoku/screens/win_screen/win_screen_provider.dart';
import 'package:flutter_sudoku/services/game_routes.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/app_strings.dart';
import 'package:flutter_sudoku/utils/app_text_styles.dart';
import 'package:flutter_sudoku/utils/extensions.dart';
import 'package:flutter_sudoku/widgets/button/rounded_button/rounded_button.dart';
import 'package:flutter_sudoku/widgets/option_widgets/option_group_widget.dart';
import 'package:flutter_sudoku/widgets/sudoku_board/horizontal_lines.dart';
import 'package:flutter_sudoku/widgets/sudoku_board/vertical_lines.dart';
import 'package:provider/provider.dart';

class WinScreen extends StatelessWidget {
  const WinScreen({
    required this.gameModel,
    super.key,
  });

  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WinScreenProvider>(
      create: (context) => WinScreenProvider(gameModel),
      child: Consumer<WinScreenProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.winScreenBg,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
              backgroundColor: AppColors.winScreenBg,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            body: CustomScrollView(
              shrinkWrap: false,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          AppStrings.levelCompleted,
                          style: AppTextStyles.winScreenHeader,
                        ),
                        MiniSudokuBoard(
                            boardModel: provider.gameModel.sudokuBoard),
                        const Spacer(),
                        LevelStatistics(gameModel: provider.gameModel),
                        NewGameButton(onPressed: () => provider.newGame()),
                        MainButton(
                            onPressed: () => GameRoutes.goTo(GameRoutes.navigationBar)),
                        const SizedBox(height: 12),
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
  const MainButton({
    required this.onPressed,
    super.key,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          AppStrings.main,
          style: AppTextStyles.mainTextButton,
        ),
      ),
    );
  }
}

class NewGameButton extends StatelessWidget {
  const NewGameButton({
    required this.onPressed,
    super.key,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: RoundedButton(
        buttonText: AppStrings.newGame,
        onPressed: onPressed,
        whiteButton: true,
      ),
    );
  }
}

class LevelStatistics extends StatelessWidget {
  const LevelStatistics({
    required this.gameModel,
    super.key,
  });

  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.statistics,
                style: AppTextStyles.levelStatisticsTitle,
              ),
              InkWell(
                onTap: () => GameRoutes.goTo(GameRoutes.navigationBar, args: [2]),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.translucentWhite,
                  ),
                  child: Text(
                    AppStrings.seeAll,
                    style: AppTextStyles.seeAll,
                  ),
                ),
              ),
            ],
          ),
        ),
        // PromotionContainer(gameModel: gameModel),
        OptionGroup(
          bgColor: AppColors.translucentWhite,
          dividerColor: Colors.white,
          options: [
            StatRowWidget(
              icon: Icons.bar_chart,
              title: AppStrings.difficulty,
              value: gameModel.difficulty.name,
            ),
            StatRowWidget(
              icon: Icons.stars_rounded,
              title: AppStrings.score,
              value: gameModel.score.toString(),
            ),
            StatRowWidget(
              icon: Icons.timer,
              title: AppStrings.time,
              value: gameModel.time.toInt().toTimeString(),
            ),
          ],
        ),
        const SizedBox(height: 22),
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
        color: AppColors.translucentWhite,
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(width: 14),
          Text(
            title,
            style: AppTextStyles.statRowText,
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.statRowText,
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
          text: AppStrings.youSetANew,
          style: AppTextStyles.promotionText,
          children: [
            TextSpan(
              text: AppStrings.bestTimeB,
              style: AppTextStyles.promotionTextGold,
            ),
            const TextSpan(
              text: AppStrings.forThe,
            ),
            TextSpan(
              text: difficulty.name,
            ),
            const TextSpan(
              text: AppStrings.difficultyLevel,
            ),
            TextSpan(
              text: time.toTimeString(),
              style: AppTextStyles.promotionTextGold,
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
        text: AppStrings.youSolvedThisPuzzle,
        style: AppTextStyles.promotionText,
        children: [
          TextSpan(
            text:
                '${timeDifference.toTimeString()} ${faster ? AppStrings.faster : AppStrings.slower}',
            style: AppTextStyles.promotionTextGold,
          ),
          const TextSpan(
            text: AppStrings.thanYourAverage,
          ),
        ],
      ),
    );
  }
}

class MiniSudokuBoard extends StatelessWidget {
  const MiniSudokuBoard({
    required this.boardModel,
    super.key,
  });

  final BoardModel boardModel;

  @override
  Widget build(BuildContext context) {
    const double borderWidth = 1.5;
    const double cellBorderWidth = 1;

    return Container(
      height: 240,
      width: 240,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Stack(
          children: [
            VerticalLines(
              borderWidth: borderWidth,
              borderColor: AppColors.boardBorder,
            ),
            HorizontalLines(
              borderWidth: borderWidth,
              borderColor: AppColors.boardBorder,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      borderColor: AppColors.cellBorder,
                    ),
                    HorizontalLines(
                      borderWidth: cellBorderWidth,
                      borderColor: AppColors.cellBorder,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
