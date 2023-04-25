import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/screens/game_screen/game_screen_provider.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/extensions.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';
import 'package:flutter_sudoku/utils/utils.dart';
import 'package:flutter_sudoku/widgets/action_button/action_button.dart';
import 'package:flutter_sudoku/widgets/action_button/action_icon.dart';
import 'package:flutter_sudoku/widgets/action_button/hints_amount_circle.dart';
import 'package:flutter_sudoku/widgets/action_button/note_switch_widget.dart';
import 'package:flutter_sudoku/widgets/appBar_action_button.dart';
import 'package:flutter_sudoku/widgets/game_info_widget.dart';
import 'package:flutter_sudoku/widgets/sudoku_board/horizontal_lines.dart';
import 'package:flutter_sudoku/widgets/sudoku_board/vertical_lines.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GameAppBar(),
      body: ChangeNotifierProvider<GameScreenProvider>(
        create: (context) => GameScreenProvider(),
        child: Consumer<GameScreenProvider>(builder: (context, provider, _) {
          return Column(
            children: [
              GameInfo(provider: provider),
              SudokuBoard(provider: provider),
              const Spacer(),
              ActionButtons(provider: provider),
              const Spacer(),
              NumberButtons(provider: provider),
              const Spacer(flex: 1),
            ],
          );
        }),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    required this.provider,
    super.key,
  });

  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionButton(
            title: Strings.undo,
            iconWidget: const ActionIcon(Icons.refresh),
            onTap: () {},
          ),
          ActionButton(
            title: Strings.erase,
            iconWidget: const ActionIcon(Icons.delete),
            onTap: () => provider.eraseOnTap(),
          ),
          ActionButton(
            title: Strings.notes,
            iconWidget: Align(
              alignment: Alignment.centerRight,
              child: Stack(
                children: [
                  const ActionIcon(
                    Icons.drive_file_rename_outline_outlined,
                    rightPadding: 16,
                  ),
                  NotesSwitchWidget(notesOn: provider.notesMode),
                ],
              ),
            ),
            onTap: () => provider.notesOnTap(),
          ),
          ActionButton(
            title: Strings.hint,
            iconWidget: Align(
              alignment: Alignment.centerRight,
              child: Stack(
                children: [
                  const ActionIcon(Icons.lightbulb_outlined, rightPadding: 12),
                  HintsAmountCircle(hints: provider.hints),
                ],
              ),
            ),
            onTap: () => provider.hintsOnTap(),
          ),
        ],
      ),
    );
  }
}

class NumberButtons extends StatelessWidget {
  const NumberButtons({
    required this.provider,
    super.key,
  });

  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(9, (index) {
          final bool showButton = provider.isNumberButtonNecessary(index + 1);

          return Opacity(
            opacity: showButton ? 1 : 0,
            child: InkWell(
              onTap: showButton
                  ? () => provider.numberButtonOnTap(index + 1)
                  : null,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                child: Text(
                  (index + 1).toString(),
                  style: provider.notesMode
                      ? AppTextStyles.noteButton
                      : AppTextStyles.numberButton,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class SudokuBoard extends StatelessWidget {
  const SudokuBoard({
    required this.provider,
    super.key,
  });

  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double borderWidth = 2;
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: cellBorderWidth,
                      crossAxisSpacing: cellBorderWidth,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, boxCellIndex) {
                      CellModel cellModel = provider.sudokuBoard
                          .getCellByBoxIndex(boxIndex, boxCellIndex);

                      return GestureDetector(
                        onTap: () => provider.cellOnTap(cellModel),
                        child: (() {
                          if (!cellModel.hasNotes) {
                            return NumberCell(
                              cell: cellModel,
                              selectedCell: provider.selectedCell,
                            );
                          } else {
                            return NoteCell(
                              cell: cellModel,
                              selectedCell: provider.selectedCell,
                            );
                          }
                        }()),
                      );
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
    required this.cell,
    required this.selectedCell,
    super.key,
  });

  final CellModel cell;
  final CellModel selectedCell;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getCellColor(cell, selectedCell),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          padding: const EdgeInsets.all(1.5),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 9,
          itemBuilder: (_, i) {
            final int number = i + 1;
            if (cell.notesContains(number)) {
              return FittedBox(
                child: Center(
                  child: Text(
                    number.toString(),
                    style: number == selectedCell.value
                        ? AppTextStyles.highlightedNoteNumber
                        : AppTextStyles.noteNumber,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}

class NumberCell extends StatelessWidget {
  const NumberCell({
    required this.cell,
    required this.selectedCell,
    super.key,
  });

  final CellModel cell;
  final CellModel selectedCell;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      color: getCellColor(cell, selectedCell),
      child: FittedBox(
        child: Center(
          child: Text(
            cell.print(),
            style: getStyle(cell),
          ),
        ),
      ),
    );
  }
}

class GameInfo extends StatelessWidget {
  const GameInfo({
    required this.provider,
    super.key,
  });

  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    final Difficulty difficulty = provider.difficulty;
    final int mistakes = provider.mistakes;
    final int score = provider.score;
    final int time = provider.time;

    final bool isPaused = provider.gamePaused;
    final Function() pauseGame = provider.pauseButtonOnTap;

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
                  value: time.toTimeString(),
                  title: Strings.time,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          PauseButton(isPaused: isPaused, onPressed: pauseGame),
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
        style: AppTextStyles.appBarTitle,
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
