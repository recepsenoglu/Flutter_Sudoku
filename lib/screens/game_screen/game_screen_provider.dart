import 'package:flutter/material.dart';
import 'package:flutter_sudoku/models/board_model.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/models/cell_position_model.dart';

class GameScreenProvider with ChangeNotifier {
  late BoardModel sudokuBoard;

  GameScreenProvider() {
    _init();
  }

  void _init() {
    _createNewBoard();
  }

  void _createNewBoard() {
    List<List<CellModel>> cells = [];

    for (var y = 0; y < 9; y++) {
      for (var x = 0; x < 9; x++) {
        final CellPositionModel position = CellPositionModel(x: x, y: y);

        final cell = CellModel(
          realValue: y * 8 + x,
          isGivenNumber: (x + 1) % 3 == 0 && (y + 1) % 3 == 0 ||
              x  % 3 == 0 && y % 3 == 0,
          isNoteCell: false,
          notes: [],
          position: position,
        );

        if (cells.length <= y) {
          cells.add([cell]);
        } else {
          cells[y].add(cell);
        }
      }
    }

    sudokuBoard = BoardModel(cells: cells);
    notifyListeners();
  }
}
