import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/models/board_model.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/models/cell_position_model.dart';
import 'package:flutter_sudoku/models/move_model.dart';
import 'package:flutter_sudoku/utils/utils.dart';

class GameScreenProvider with ChangeNotifier {
  late BoardModel sudokuBoard;
  late CellModel selectedCell;

  Difficulty difficulty = Difficulty.Easy;
  int mistakes = 0;
  int score = 0;
  int time = 0;

  bool gamePaused = false;

  bool notesMode = false;
  int hints = 3;

  GameScreenProvider() {
    _init();
  }

  void _init() {
    _createSudokuBoard();
    selectedCell = sudokuBoard.getCellByCoordinates(0, 0);
    _selectCell(selectedCell);
    _startTimer();
    notifyListeners();
  }

  void _createSudokuBoard() {
    _createEmptyBoard();
    _fillTheBoard();
    _giveStartNumbers();
  }

  void _createEmptyBoard() {
    List<List<CellModel>> cells = List.generate(
        9,
        (y) => List.generate(
            9,
            (x) => CellModel(
                  position: CellPositionModel(y: y, x: x),
                  realValue: 0,
                  notes: [],
                )));

    sudokuBoard = BoardModel(cells: cells, movesLog: []);
  }

  void _fillTheBoard() {
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
    if (noAvailableNumbers) _fillTheBoard();
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
      if (gamePaused) {
        timer.cancel();
        return;
      }
      time++;
      notifyListeners();
    });
  }

  void _pauseGame() {
    gamePaused = true;
  }

  void _resumeGame() {
    gamePaused = false;
    _startTimer();
  }

  void pauseButtonOnTap() {
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
      }
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
