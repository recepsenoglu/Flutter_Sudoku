import 'package:flutter/material.dart';
import 'package:flutter_sudoku/models/board_model.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/models/cell_position_model.dart';

class GameScreenProvider with ChangeNotifier {
  late BoardModel sudokuBoard;
  late CellModel selectedCell;

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
    List<List<CellModel>> cells = [];

    for (var y = 0; y < 9; y++) {
      for (var x = 0; x < 9; x++) {
        final CellPositionModel position = CellPositionModel(x: x, y: y);

        bool isGiven = x == 4 && y == 6 || x == 8 && y == 3;
        bool isNoteCell = x == 3 && y == 7 || x == 1 && y == 6;

        int realValue = x % 2 == 0 ? 8 : 5;
        int? value = !isNoteCell && x == 2 && y == 4 || x == 7 && y == 7
            ? x % 2 == 0
                ? realValue
                : realValue - 1
            : null;

        final cell = CellModel(
          value: isGiven ? realValue : value,
          realValue: realValue,
          position: position,
          isGivenNumber: isGiven,
          isNoteCell: isNoteCell,
          notes: [1, 8],
        );

        if (cells.length <= y) {
          cells.add([cell]);
        } else {
          cells[y].add(cell);
        }
      }
    }

    sudokuBoard = BoardModel(cells: cells);
  }

  void cellOnTap(CellModel cellModel) {
    _selectCell(cellModel);
    _highlightCells(cellModel);
  }

  void _selectCell(CellModel cellModel) {
    selectedCell.isSelected = false;
    sudokuBoard.updateCell(selectedCell);

    cellModel.isSelected = true;
    sudokuBoard.updateCell(cellModel);

    selectedCell = cellModel;
    notifyListeners();
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

    notifyListeners();
  }

  void _removeAllHighlights() {
    sudokuBoard.allCells
        .where((element) => element.isHighlighted)
        .forEach((element) {
      element.isHighlighted = false;
      sudokuBoard.updateCell(element);
    });

    notifyListeners();
  }
}
