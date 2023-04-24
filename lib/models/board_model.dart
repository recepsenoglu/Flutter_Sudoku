import 'package:flutter_sudoku/models/cell_model.dart';

class BoardModel {
  final List<List<CellModel>> cells;

  BoardModel({
    required this.cells,
  });

  List<CellModel> _getAllCells() {
    List<CellModel> allCells = [];

    for (var y = 0; y < 9; y++) {
      for (var x = 0; x < 9; x++) {
        allCells.add(cells[y][x]);
      }
    }
    return allCells;
  }

  List<CellModel> get allCells => _getAllCells();

  CellModel getCellByCoordinates(int y, int x) {
    return cells[y][x];
  }

  CellModel getCellByBoxIndex(int boxIndex, int boxCellIndex) {
    final int y = (boxIndex / 3).floor() * 3 + (boxCellIndex / 3).floor();
    final int x = boxIndex % 3 * 3 + (boxCellIndex % 3);

    return cells[y][x];
  }

  void updateCell(CellModel cellModel) {
    final int y = cellModel.position.y;
    final int x = cellModel.position.x;

    cells[y][x] = cellModel;
  }
}
