import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';
import 'package:flutter_sudoku/widgets/appBar_action_button.dart';
import 'package:flutter_sudoku/widgets/game_info_widget.dart';
import 'package:flutter_sudoku/widgets/sudoku_board/horizontal_lines.dart';
import 'package:flutter_sudoku/widgets/sudoku_board/vertical_lines.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GameAppBar(),
      body: Column(
        children: const [
          GameInfo(
            difficulty: Difficulty.Easy,
            mistakes: 1,
            score: 100,
            time: 149,
          ),
          SudokuBoard(),
          Spacer(),
          NumberButtons(),
          Spacer(),
        ],
      ),
    );
  }
}

class NumberButtons extends StatelessWidget {
  const NumberButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          9,
          (index) => Text(
            (index + 1).toString(),
            style: TextStyle(
              color: AppColors.numberButton,
              fontSize: 34,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class SudokuBoard extends StatelessWidget {
  const SudokuBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double borderWidth = 3;
    double cellBorderWidth = 1.5;

    return Container(
      width: double.infinity,
      height: screenWidth - 12,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth),
      ),
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: borderWidth,
              crossAxisSpacing: borderWidth,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: cellBorderWidth,
                      crossAxisSpacing: cellBorderWidth,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      if (index % 2 == 0) {
                        return NumberCell(index: index);
                      }

                      return const NoteCell();
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class NoteCell extends StatelessWidget {
  const NoteCell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          padding: const EdgeInsets.all(2),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 9,
          itemBuilder: (_, i) {
            return Center(
              child: Text(
                (i + 1).toString(),
                style: TextStyle(
                  color: i != 5
                      ? AppColors.noteNumber
                      : AppColors.highlightedNoteNumber,
                  fontSize: 12,
                ),
              ),
            );
          }),
    );
  }
}

class NumberCell extends StatelessWidget {
  const NumberCell({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          ((index % 9) + 1).toString(),
          style: index % 2 == 0
              ? AppTextStyles.givenNumber
              : AppTextStyles.enteredNumber,
        ),
      ),
    );
  }
}

class GameInfo extends StatelessWidget {
  const GameInfo({
    required this.difficulty,
    required this.mistakes,
    required this.score,
    required this.time,
    super.key,
  });

  final Difficulty difficulty;
  final int mistakes;
  final int score;
  final int time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GameInfoWidget(
                  value: difficulty.name,
                  title: Strings.difficulty,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                GameInfoWidget(
                  value: '$mistakes/3',
                  title: Strings.mistakes,
                ),
                GameInfoWidget(
                  value: '$score',
                  title: Strings.score,
                ),
                GameInfoWidget(
                  value: '$time',
                  title: Strings.time,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          PauseButton(isPaused: false, onPressed: () {}),
        ],
      ),
    );
  }
}

class PauseButton extends StatelessWidget {
  const PauseButton({
    required this.isPaused,
    required this.onPressed,
    super.key,
  });

  final bool isPaused;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.pauseButton,
        ),
        child: Icon(
          isPaused ? Icons.play_arrow : Icons.pause_outlined,
          color: AppColors.pauseIcon,
          size: 24,
        ),
      ),
    );
  }
}

class GameAppBar extends StatelessWidget with PreferredSizeWidget {
  const GameAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBackground,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      elevation: 0,
      title: Text(
        Strings.appBarTitle,
        style: TextStyle(
          color: AppColors.appBarTitle,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading:
          AppBarActionButton(icon: Icons.arrow_back_ios_new, onPressed: () {}),
      actions: [
        AppBarActionButton(
          icon: Icons.palette_outlined,
          onPressed: () {},
        ),
        AppBarActionButton(
          icon: Icons.settings_outlined,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
