import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/models/cell_position_model.dart';

class MoveModel {
  final CellPositionModel cellPosition;
  final int value;
  final int oldValue;
  final List<int> notes;
  final List<int> oldNotes;

  MoveModel({
    required this.cellPosition,
    required this.value,
    required this.oldValue,
    required this.notes,
    required this.oldNotes,
  });

  String print() =>
      'value: $value, oldValue: $oldValue, notes: $notes, oldNotes: $oldNotes';
}
