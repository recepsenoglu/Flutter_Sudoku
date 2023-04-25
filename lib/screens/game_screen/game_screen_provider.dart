import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/models/board_model.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/models/cell_position_model.dart';
import 'package:flutter_sudoku/utils/utils.dart';

class GameScreenProvider with ChangeNotifier {
  late BoardModel sudokuBoard;
  late CellModel selectedCell;

  Difficulty difficulty = Difficulty.Easy;
  int mistakes = 0;
  int score = 0;
  int time = 0;

  bool notesMode = false;
  int hints = 3;

  GameScreenProvider() {
    _init();
  }

  void _init() {
    _createSudokuBoard();
    selectedCell = sudokuBoard.getCellByCoordinates(0, 0);
    _selectCell(selectedCell);

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

    sudokuBoard = BoardModel(cells: cells);
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

  void numberButtonOnTap(int number) {
    if (!selectedCell.isGivenNumber && !selectedCell.isValueCorrect) {
      if (notesMode) {
        _clearValue();
        _enterNote(number);
      } else {
        _clearNotes();
        _enterValue(number);
      }

      _updateSelectedCell();
      notifyListeners();
    }
  }

  void _enterNote(int number) {
    if (selectedCell.notesContains(number)) {
      selectedCell.notes.remove(number);
    } else {
      selectedCell.notes.add(number);
    }
  }

  void _enterValue(int number) {
    if (selectedCell.value != number) {
      selectedCell.value = number;
      if (selectedCell.realValue != selectedCell.value) {
        mistakes += 1;
      }
    }
  }

  void _clearValue() {
    selectedCell.value = null;
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

  void eraseOnTap() {
    if (!selectedCell.isGivenNumber && !selectedCell.isValueCorrect) {
      if (selectedCell.hasNotes) {
        _deleteLastNote();
      } else {
        _deleteNumber();
      }
      notifyListeners();
    }
  }

  void _deleteLastNote() {
    selectedCell.notes.removeLast();
    _updateSelectedCell();
  }

  void _deleteNumber() {
    selectedCell.value = null;
    _updateSelectedCell();
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
