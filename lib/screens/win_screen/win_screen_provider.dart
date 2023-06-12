import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/constant/game_constants.dart';
import 'package:flutter_sudoku/models/game_model.dart';
import 'package:flutter_sudoku/services/routes.dart';
import 'package:flutter_sudoku/widgets/modal_bottom_sheet/modal_bottom_sheets.dart';

class WinScreenProvider with ChangeNotifier {
  Future<void> newGame() async {
    Difficulty? newGameDifficulty = await ModalBottomSheets.chooseDifficulty();

    if (newGameDifficulty != null) {
      final GameModel gameModel = GameModel(
        sudokuBoard: GameSettings.createSudokuBoard(),
        difficulty: newGameDifficulty,
      );

      Routes.goTo(Routes.gameScreen, args: gameModel);
    }
  }
}
