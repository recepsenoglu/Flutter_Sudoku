import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../constant/enums.dart';
import '../../constant/game_constants.dart';
import '../../models/board_model.dart';
import '../../models/cell_model.dart';
import '../../models/cell_position_model.dart';
import '../../models/game_model.dart';
import '../../models/game_stats_model.dart';
import '../../models/move_model.dart';
import '../../services/storage_service.dart';
import '../../utils/extensions.dart';
import '../../utils/game_routes.dart';
import '../../utils/utils.dart';
import '../../widgets/modal_bottom_sheet/modal_bottom_sheets.dart';
import '../../widgets/popups.dart';

class GameScreenProvider with ChangeNotifier {
  late StorageService storageService;
  late GameModel gameModel;
  late CellModel selectedCell;

  Difficulty get difficulty => gameModel.difficulty;

  BoardModel get sudokuBoard => gameModel.sudokuBoard;

  int get mistakes => gameModel.mistakes;
  int get score => gameModel.score;
  int get time => gameModel.time;
  int get hints => gameModel.hints;

  set sudokuBoard(value) => gameModel.sudokuBoard = value;

  set mistakes(int value) => gameModel.mistakes = value;
  set score(int value) => gameModel.score = value;
  set time(int value) => gameModel.time = value;
  set hints(int value) => gameModel.hints = value;

  bool notesMode = false;

  bool gamePaused = false;
  bool gameOver = false;

  bool _mounted = false;
  bool get mounted => _mounted;

  @override
  void dispose() {
    super.dispose();
    _mounted = true;
  }

  GameScreenProvider({required this.gameModel}) {
    _init();
  }

  Future<void> onBackPressed() async {
    if (isDailyChallenge) {
      GameRoutes.goTo(GameRoutes.navigationBar);
    } else {
      final GameModel currentGame = await _getCurrentGame();
      GameRoutes.goTo(GameRoutes.navigationBar, args: [0, currentGame]);
    }
  }

  Future<void> onSettingsPressed() async {
    _pauseGame();
    notifyListeners();

    await GameRoutes.goTo(
      GameRoutes.optionsScreen,
      enableBack: true,
      callBackAfter: _resumeGame,
    );
    notifyListeners();
  }

  Future<void> _init() async {
    _createNewGame(gameModel);
    storageService = await StorageService.initialize();
    await _saveGame();
  }

  Future<void> _saveGame() async {
    if (gameModel.dailyChallenge) {
      return;
    }
    await storageService.saveGame(gameModel);
  }

  Future<GameModel> _getCurrentGame() async {
    await _saveGame();
    return gameModel;
  }

  void _createNewGame(GameModel newGame) {
    gameModel = newGame;

    if (gameModel.isOnGoingGame) {
      debugPrint(
          'Continuing ${gameModel.difficulty.name.toUpperCase()} game - TIME: ${gameModel.time.toTimeString()}');
    } else {
      _clearGame();
      debugPrint(
          'Creating a new ${gameModel.difficulty.name.toUpperCase()} game ');
      _fillTheBoard();
      _saveGameStarted();
    }

    selectedCell = sudokuBoard.getCellByCoordinates(0, 0);
    _selectCell(selectedCell);
    _startTimer();
    notifyListeners();
  }

  Future<void> _saveGameStarted() async {
    if (gameModel.dailyChallenge) {
      return;
    }
    final DateTime now = DateTime.now();

    GameStatsModel gameStatsModel = GameStatsModel(
      difficulty: difficulty,
      dateTime: now,
      startTime: now,
    );

    storageService = await StorageService.initialize();

    await storageService.saveGameStats(gameStatsModel);
  }

  void _fillTheBoard() {
    _fillNumbers();
    _giveStartNumbers();
  }

  void _fillNumbers() {
    bool noAvailableNumbers = false;

    for (var y = 0; y < 9; y++) {
      if (noAvailableNumbers) break;
      for (var x = 0; x < 9; x++) {
        CellModel cell = sudokuBoard.getCellByBoxIndex(y, x);

        final Set<int> intersectedValues =
            sudokuBoard.getIntersectedValues(cell);

        noAvailableNumbers = intersectedValues.length > 8;

        if (!noAvailableNumbers) {
          final int randomNumber =
              generateRandomNumber(exclude: intersectedValues);
          cell.realValue = randomNumber;
          sudokuBoard.updateCell(cell);
        } else {
          sudokuBoard.clearCells();
          noAvailableNumbers = true;
          break;
        }
      }
    }
    if (noAvailableNumbers) _fillNumbers();
  }

  void _giveStartNumbers() {
    for (final CellPositionModel cellPosition
        in getRandomPositions(difficulty)) {
      CellModel cell = sudokuBoard.getCellByPosition(cellPosition);
      cell.isGivenNumber = true;
      cell.value = cell.realValue;
      sudokuBoard.updateCell(cell);
    }
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (gamePaused || gameOver || _mounted) {
        timer.cancel();
        return;
      }
      time++;
      notifyListeners();
    });
  }

  void _clearGame() {
    debugPrint('Clearing game...');

    gamePaused = false;
    gameOver = false;
    notesMode = false;
  }

  void _pauseGame() {
    debugPrint('Game paused');

    gamePaused = true;
  }

  void _resumeGame() {
    debugPrint('Game resumed');

    gamePaused = false;
    _startTimer();
    notifyListeners();
  }

  void pauseButtonOnTap() {
    Popup.gamePaused(
      time: time,
      mistakes: mistakes,
      difficulty: difficulty,
      onResume: _resumeGame,
    );

    if (gamePaused) {
      _resumeGame();
    } else {
      _pauseGame();
    }
    notifyListeners();
  }

  void cellOnTap(CellModel cellModel) {
    _selectCell(cellModel);
    _highlightCells(cellModel);
    notifyListeners();
  }

  void _selectCell(CellModel cellModel) {
    selectedCell = cellModel;
  }

  void _updateSelectedCell() {
    sudokuBoard.updateCell(selectedCell);
    _highlightCells(selectedCell);
  }

  void _highlightCells(CellModel cellModel) {
    _removeAllHighlights();

    sudokuBoard.allCells
        .where(
      (element) =>
          element.position.x == cellModel.position.x ||
          element.position.y == cellModel.position.y ||
          element.position.boxIndex == cellModel.position.boxIndex ||
          element.hasValue && element.value == cellModel.value,
    )
        .forEach((element) {
      element.isHighlighted = true;
      sudokuBoard.updateCell(element);
    });
  }

  void _removeAllHighlights() {
    sudokuBoard.allCells
        .where((element) => element.isHighlighted)
        .forEach((element) {
      element.isHighlighted = false;
      sudokuBoard.updateCell(element);
    });
  }

  void addMoveToLog({
    required int value,
    required int oldValue,
    required List<int> notes,
    required List<int> oldNotes,
  }) {
    final MoveModel moveModel = MoveModel(
      cellPosition: selectedCell.position,
      value: value,
      oldValue: oldValue,
      notes: notes,
      oldNotes: oldNotes,
    );

    sudokuBoard.movesLog.add(moveModel);
  }

  void numberButtonOnTap(int number) {
    if (!selectedCell.isGivenNumber || !selectedCell.isValueCorrect) {
      if (notesMode) {
        _enterNote(number);
      } else {
        _enterValue(number);
      }
      _saveGame();
      _updateSelectedCell();
      notifyListeners();
    } else {
      debugPrint('Number is given');
      // selectedCell.isGivenNumber = false;
      // notifyListeners();
    }
  }

  void _enterNote(int number) {
    final List<int> oldNotes = List<int>.from(selectedCell.notes);

    if (selectedCell.notesContains(number)) {
      selectedCell.notes.remove(number);
    } else {
      selectedCell.notes.add(number);
    }

    addMoveToLog(
      value: 0,
      oldValue: selectedCell.value,
      notes: List<int>.from(selectedCell.notes),
      oldNotes: oldNotes,
    );

    _clearValue();
  }

  void _enterValue(int number, {bool isHint = false}) {
    if (selectedCell.value != number) {
      if (isHint) {
        selectedCell.isGivenNumber = true;
      } else {
        addMoveToLog(
          value: number,
          oldValue: selectedCell.value,
          notes: [],
          oldNotes: List<int>.from(selectedCell.notes),
        );
      }

      _clearNotes();
      selectedCell.value = number;
      if (selectedCell.realValue != selectedCell.value) {
        mistakes += 1;
        score = score >= 75 ? score - 75 : 0;
        if (mistakes == 3) {
          _gameOver();
        }
      } else if (!selectedCell.scored) {
        Random random = Random();
        int factor = random.nextInt(3) + 1;
        score += 50 + (factor * 25);
        selectedCell.scored = true;
      }

      _checkIsCompleted();
    }
  }

  void _checkIsCompleted() {
    if (sudokuBoard.isCompleted) {
      _gameOver(win: true);
    }
  }

  Future<void> _saveGameStats() async {
    if (gameModel.dailyChallenge) {
      return;
    }
    final DateTime now = DateTime.now();

    GameStatsModel gameStatsModel = GameStatsModel(
      dateTime: now,
      startTime: now,
      difficulty: difficulty,
      won: false,
      score: score,
      time: time,
      mistakes: mistakes,
    );

    await storageService.saveGameStats(gameStatsModel);
  }

  Future<void> _gameOver({bool win = false}) async {
    gameOver = true;
    notifyListeners();

    await _saveGameStats();
    await storageService.deleteGame();
    if (win) {
      GameRoutes.goTo(GameRoutes.winScreen, args: gameModel);
    } else {
      Popup.gameOver(onNewGame: _chooseNewGameDifficulty, onExit: _onExit);
    }
  }

  Future<void> _chooseNewGameDifficulty() async {
    Difficulty? chosenDifficulty =
        await ModalBottomSheets.chooseDifficulty(restartDifficulty: difficulty);

    if (chosenDifficulty != null) {
      final GameModel gameModel = GameModel(
        sudokuBoard: GameSettings.createSudokuBoard(),
        difficulty: chosenDifficulty,
      );

      _createNewGame(gameModel);
    } else {
      Future.delayed(
          const Duration(milliseconds: 300),
          () => Popup.gameOver(
              onNewGame: _chooseNewGameDifficulty, onExit: _onExit));
    }
  }

  Future<void> _onExit() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      GameRoutes.goTo(GameRoutes.navigationBar, args: [0, null]);
    });
  }

  void _clearValue() {
    if (selectedCell.hasValue) {
      selectedCell.value = 0;
    }
  }

  void _clearNotes() {
    if (selectedCell.hasNotes) {
      selectedCell.notes.clear();
    }
  }

  void _clearCell() {
    _clearValue();
    _clearNotes();
  }

  void undoOnTap() {
    if (sudokuBoard.hasLog) {
      final MoveModel moveModel = sudokuBoard.lastMove;

      CellModel cell = sudokuBoard.getCellByPosition(moveModel.cellPosition);
      _selectCell(cell);

      if (moveModel.value != moveModel.oldValue) {
        cell.value = moveModel.oldValue;
      }
      if (moveModel.notes != moveModel.oldNotes) {
        cell.notes = List.from(moveModel.oldNotes);
      }
      sudokuBoard.movesLog.removeLast();

      _saveGame();
      _updateSelectedCell();
      notifyListeners();
    }
  }

  void eraseOnTap() {
    if (!selectedCell.isGivenNumber && !selectedCell.isValueCorrect) {
      if (selectedCell.hasValue) {
        _deleteNumber();
      } else if (selectedCell.hasNotes) {
        _deleteLastNote();
      }
      _saveGame();
      notifyListeners();
    }
  }

  void _deleteLastNote() {
    final List<int> oldNotes = List<int>.from(selectedCell.notes);

    selectedCell.notes.removeLast();
    addMoveToLog(
      value: 0,
      oldValue: 0,
      notes: List<int>.from(selectedCell.notes),
      oldNotes: oldNotes,
    );

    _updateSelectedCell();
  }

  void _deleteNumber() {
    if (selectedCell.hasValue) {
      addMoveToLog(
        value: 0,
        oldValue: selectedCell.value,
        notes: [],
        oldNotes: [],
      );
      selectedCell.value = 0;
      _updateSelectedCell();
    }
  }

  void notesOnTap() {
    notesMode = !notesMode;
    notifyListeners();
  }

  void hintsOnTap() {
    if (_canGetHint) {
      _giveHint();
      _saveGame();
    }
  }

  bool get _canGetHint =>
      !selectedCell.isGivenNumber && !selectedCell.isValueCorrect && hints > 0;

  void _giveHint() {
    hints -= 1;
    _clearCell();
    _enterValue(selectedCell.realValue, isHint: true);
    _updateSelectedCell();
    notifyListeners();
  }

  bool isNumberButtonNecessary(int number) {
    return sudokuBoard.allCells
            .where((element) => element.value == number)
            .toList()
            .length <
        9;
  }

  bool get isDailyChallenge => gameModel.isDailyChallenge;
}
