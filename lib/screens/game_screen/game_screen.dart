import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/enums.dart';
import '../../models/cell_model.dart';
import '../../models/game_model.dart';
import '../../utils/exports.dart';
import '../../widgets/app_bar_action_button.dart';
import '../../widgets/button/action_button/exports.dart';
import '../../widgets/game_info/exports.dart';
import '../../widgets/sudoku_board/exports.dart';
import 'game_screen_provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({required this.gameModel, super.key});
  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameScreenProvider>(
      create: (context) => GameScreenProvider(gameModel: gameModel),
      child: Consumer<GameScreenProvider>(builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: GameColors.background,
          appBar: GameAppBar(
            onBackPressed: provider.onBackPressed,
            onSettingsPressed: provider.onSettingsPressed,
          ),
          body: Column(
            children: [
              GameInfo(provider: provider),
              SudokuBoard(provider: provider),
              const Spacer(),
              ActionButtons(provider: provider),
              const Spacer(),
              NumberButtons(provider: provider),
              const Spacer(flex: 1),
            ],
          ),
        );
      }),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.provider, super.key});

  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: GameSizes.getHorizontalPadding(0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionButton(
            title: GameStrings.undo,
            iconWidget: const ActionIcon(Icons.refresh),
            onTap: () => provider.undoOnTap(),
          ),
          ActionButton(
            title: GameStrings.erase,
            iconWidget: const ActionIcon(Icons.delete),
            onTap: () => provider.eraseOnTap(),
          ),
          ActionButton(
            title: GameStrings.notes,
            iconWidget: Stack(
              children: [
                const ActionIcon(Icons.drive_file_rename_outline_outlined),
                NotesSwitchWidget(notesOn: provider.notesMode),
              ],
            ),
            onTap: () => provider.notesOnTap(),
          ),
          ActionButton(
            title: GameStrings.hint,
            iconWidget: Stack(
              children: [
                const ActionIcon(Icons.lightbulb_outlined),
                HintsAmountCircle(hints: provider.hints),
              ],
            ),
            onTap: () => provider.hintsOnTap(),
          ),
        ],
      ),
    );
  }
}

class NumberButtons extends StatelessWidget {
  const NumberButtons({required this.provider, super.key});

  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: GameSizes.getHorizontalPadding(0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(9, (index) {
          final bool showButton = provider.isNumberButtonNecessary(index + 1);

          return Visibility(
            visible: showButton,
            child: InkWell(
              onTap: showButton
                  ? () => provider.numberButtonOnTap(index + 1)
                  : null,
              borderRadius: GameSizes.getRadius(8),
              child: Padding(
                padding: GameSizes.getSymmetricPadding(0.015, 0.015),
                child: Text(
                  (index + 1).toString(),
                  style: provider.notesMode
                      ? GameTextStyles.noteButton
                          .copyWith(fontSize: GameSizes.getWidth(0.09))
                      : GameTextStyles.numberButton
                          .copyWith(fontSize: GameSizes.getWidth(0.09)),
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
                      CellModel cell = provider.sudokuBoard
                          .getCellByBoxIndex(boxIndex, boxCellIndex);

                      return CellWidget(
                        provider: provider,
                        cell: cell,
                        child: (() {
                          if (provider.gamePaused) {
                            return null;
                          } else {
                            if (cell.hasValue) {
                              return CellValueText(cell: cell);
                            } else {
                              return CellNotesGrid(
                                cell: cell,
                                selectedCell: provider.selectedCell,
                              );
                            }
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

class CellWidget extends StatelessWidget {
  const CellWidget({
    super.key,
    required this.provider,
    required this.cell,
    required this.child,
  });

  final GameScreenProvider provider;
  final CellModel cell;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => provider.cellOnTap(cell),
      child: Container(
        padding: const EdgeInsets.all(2),
        color: getCellColor(
          cell: cell,
          selectedCell: provider.selectedCell,
          hideCells: provider.gamePaused,
        ),
        child: child,
      ),
    );
  }
}

class CellNotesGrid extends StatelessWidget {
  const CellNotesGrid({
    required this.cell,
    required this.selectedCell,
    super.key,
  });

  final CellModel cell;
  final CellModel selectedCell;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                      ? GameTextStyles.highlightedNoteNumber
                      : GameTextStyles.noteNumber,
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

class CellValueText extends StatelessWidget {
  const CellValueText({
    required this.cell,
    super.key,
  });

  final CellModel cell;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Center(
        child: Text(
          cell.print(),
          style: getStyle(cell),
        ),
      ),
    );
  }
}

class GameInfo extends StatelessWidget {
  const GameInfo({required this.provider, super.key});

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
      padding: GameSizes.getPadding(0.025),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GameInfoWidget(
                  value: difficulty.name,
                  title: GameStrings.difficulty,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                GameInfoWidget(
                  value: '$mistakes/3',
                  title: GameStrings.mistakes,
                ),
                GameInfoWidget(
                  value: '$score',
                  title: GameStrings.score,
                ),
                GameInfoWidget(
                  value: time.toTimeString(),
                  title: GameStrings.time,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ],
            ),
          ),
          SizedBox(width: GameSizes.getWidth(0.03)),
          PauseButton(isPaused: isPaused, onPressed: pauseGame),
        ],
      ),
    );
  }
}

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBar({
    required this.onBackPressed,
    required this.onSettingsPressed,
    super.key,
  });

  final Function() onBackPressed;
  final Function() onSettingsPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: GameColors.appBarBackground,
      centerTitle: true,
      elevation: 0,
      toolbarHeight: GameSizes.getHeight(0.08),
      title: Text(GameStrings.appBarTitle,
          style: GameTextStyles.appBarTitle.copyWith(
            fontSize: GameSizes.getHeight(0.029),
          )),
      leadingWidth: GameSizes.getHeight(0.06),
      leading: AppBarActionButton(
        icon: Icons.arrow_back_ios_new,
        onPressed: onBackPressed,
        iconSize: GameSizes.getHeight(0.033),
      ),
      actions: [
        // AppBarActionButton(
        //   icon: Icons.palette_outlined,
        //   onPressed: () {},
        // ),
        AppBarActionButton(
          icon: Icons.settings_outlined,
          onPressed: onSettingsPressed,
        ),
        SizedBox(width: GameSizes.getWidth(0.02)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(GameSizes.getHeight(0.08));
}
