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

        int realValue = x % 2 == 0 ? 9 : 1;
        int value = x % 2 == 0 ? realValue : 7;

        final cell = CellModel(
          value: value,
          realValue: realValue,
          position: position,
          isGivenNumber:
              (x + 1) % 3 == 0 && (y + 1) % 3 == 0 || x % 3 == 0 && y % 3 == 0,
          isNoteCell: x % 2 == 0,
          notes: [1,8],
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
