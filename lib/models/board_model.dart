import 'package:flutter_sudoku/models/cell_model.dart';

class BoardModel {
  final List<List<CellModel>> cells;

  BoardModel({
    required this.cells,
  });

  CellModel getCellByBoxIndex(int boxIndex, int boxCellIndex) {
    final int y = (boxIndex / 3).floor() + (boxCellIndex / 3).floor();
    final int x = boxCellIndex % 3 + 3 * (boxIndex / 3).floor();

    return cells[y][x];
  }
}
