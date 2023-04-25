import 'package:flutter/material.dart';
import 'package:flutter_sudoku/models/board_model.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/models/cell_position_model.dart';

class GameScreenProvider with ChangeNotifier {
  late BoardModel sudokuBoard;
  late CellModel selectedCell;
  bool notesMode = false;

  GameScreenProvider() {
    _init();
  }

  void _init() {
    _createNewBoard();
    selectedCell = sudokuBoard.getCellByCoordinates(0, 0);
    _selectCell(selectedCell);

    notifyListeners();
  }

  void _createNewBoard() {
    List<List<CellModel>> cells = List.generate(
        9,
        (y) => List.generate(
            9,
            (x) => CellModel(
                  position: CellPositionModel(y: y, x: x),
                  realValue: 0,
                )));

    sudokuBoard = BoardModel(cells: cells);

    _fillSudokuBoard();
  }

  void _fillSudokuBoard() {
    bool noAvailableNumbers = false;

    for (var y = 0; y < 9; y++) {
      if (noAvailableNumbers) break;
      for (var x = 0; x < 9; x++) {
        CellModel cell = sudokuBoard.getCellByBoxIndex(y, x);

        final Set<int> intersectedValues =
            sudokuBoard.getIntersectedValues(cell);

        noAvailableNumbers = intersectedValues.length > 8;

        if (!noAvailableNumbers) {
          final int randomNumber = _randomNumber(exclude: intersectedValues);
          cell.realValue = randomNumber;
          cell.value = cell.realValue;
        } else {
          sudokuBoard.clearCells();
          noAvailableNumbers = true;
          break;
        }
      }
    }
    if (noAvailableNumbers) _fillSudokuBoard();
  }

  int _randomNumber({required Set<int> exclude}) {
    List<int> numberList = List<int>.from([1, 2, 3, 4, 5, 6, 7, 8, 9]);

    numberList.removeWhere((element) => exclude.contains(element));

    numberList.shuffle();

    return numberList.first;
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
  }

  void _highlightCells(CellModel cellModel) {
    _removeAllHighlights();

    sudokuBoard.allCells
        .where(
      (element) =>
          // element.position.x == cellModel.position.x ||
          // element.position.y == cellModel.position.y ||
          // element.position.boxIndex == cellModel.position.boxIndex ||
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
        _enterNote(number);
      } else {
        _enterValue(number);
        _clearNotes();
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
    selectedCell.value = number;
  }

  void _clearNotes() {
    if (selectedCell.hasNotes) {
      selectedCell.notes.clear();
    }
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
}
