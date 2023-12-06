import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/constant/game_constants.dart';
import 'package:flutter_sudoku/models/game_model.dart';
import 'package:flutter_sudoku/services/game_routes.dart';
import 'package:flutter_sudoku/services/storage_service.dart';
import 'package:flutter_sudoku/utils/extensions.dart';
import 'package:flutter_sudoku/widgets/modal_bottom_sheet/modal_bottom_sheets.dart';

class MainScreenProvider with ChangeNotifier {
  GameModel? savedGame;

  MainScreenProvider({this.savedGame}) {
    _init();
  }

  Future<void> _init() async {
    StorageService storageService = await StorageService.initialize();

    savedGame = storageService.getSavedGame();
    notifyListeners();
  }

  bool get isThereASavedGame => savedGame != null;

  String get continueGameButtonText => isThereASavedGame
      ? '${savedGame!.time.toTimeString()} - ${savedGame!.difficulty.name}'
      : '';

  Future<void> newGame() async {
    Difficulty? newGameDifficulty = await ModalBottomSheets.chooseDifficulty();

    if (newGameDifficulty != null) {
      final GameModel gameModel = GameModel(
        sudokuBoard: GameSettings.createSudokuBoard(),
        difficulty: newGameDifficulty,
      );

      GameRoutes.goTo(GameRoutes.gameScreen, args: gameModel);
    }
  }

  void continueGame() {
    if (isThereASavedGame) {
      GameRoutes.goTo(GameRoutes.gameScreen, args: savedGame);
    }
  }
}
