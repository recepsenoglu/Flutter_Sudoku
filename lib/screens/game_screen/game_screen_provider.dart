import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/constant/game_constants.dart';
import 'package:flutter_sudoku/models/board_model.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/models/cell_position_model.dart';
import 'package:flutter_sudoku/models/game_model.dart';
import 'package:flutter_sudoku/models/game_stats_model.dart';
import 'package:flutter_sudoku/models/move_model.dart';
import 'package:flutter_sudoku/models/statistics_model.dart';
import 'package:flutter_sudoku/services/storage_service.dart';
import 'package:flutter_sudoku/utils/extensions.dart';
import 'package:flutter_sudoku/utils/utils.dart';
import 'package:flutter_sudoku/widgets/modal_bottom_sheet/modal_bottom_sheets.dart';
import 'package:flutter_sudoku/widgets/popups.dart';

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

  Future<void> _init() async {
    _createNewGame(gameModel);
    storageService = await StorageService.initialize();
    await _saveGame();
  }

  Future<void> _saveGame() async {
    await storageService.saveGame(gameModel);
  }

  Future<GameModel> getCurrentGame() async {
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
    final DateTime now = DateTime.now();

    GameStatsModel gameStatsModel = GameStatsModel(
      difficulty: difficulty,
      dateTime: now,
      startTime: now,
    );

    storageService = await StorageService.initialize();

    await storageService.saveGameStats(gameStatsModel);
    print("GAME STATS SAVED");

    StatisticsModel? statisticsModel = storageService.getStatistics(difficulty);

    if (statisticsModel != null) {
      print('GAME STATS FETCHED');
      print(statisticsModel.statistics.length.toString());
    }
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
    gamePaused = true;
  }

  void _resumeGame() {
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
    if (!selectedCell.isGivenNumber && !selectedCell.isValueCorrect) {
      if (notesMode) {
        _enterNote(number);
      } else {
        _enterValue(number);
      }
      _saveGame();
      _updateSelectedCell();
      notifyListeners();
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

  void _enterValue(int number) {
    if (selectedCell.value != number) {
      addMoveToLog(
        value: number,
        oldValue: selectedCell.value,
        notes: [],
        oldNotes: List<int>.from(selectedCell.notes),
      );

      _clearNotes();

      selectedCell.value = number;
      if (selectedCell.realValue != selectedCell.value) {
        mistakes += 1;
        if (mistakes == 3) {
          _gameOver();
        }
      }
    }
  }

  Future<void> _saveGameStats() async {
    final DateTime now = DateTime.now();

    GameStatsModel gameStatsModel = GameStatsModel(
      dateTime: now,
      startTime: now,
      difficulty: difficulty,
      score: score,
      time: time,
      won: false,
    );
    
    await storageService.saveGameStats(gameStatsModel);
  }

  void _gameOver() {
    gameOver = true;
    notifyListeners();

    _saveGameStats();

    Popup.gameOver(onNewGame: _chooseNewGameDifficulty);
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
      Future.delayed(const Duration(milliseconds: 300),
          () => Popup.gameOver(onNewGame: _chooseNewGameDifficulty));
    }
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
    selectedCell.isGivenNumber = true;
    selectedCell.value = selectedCell.realValue;
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
}
