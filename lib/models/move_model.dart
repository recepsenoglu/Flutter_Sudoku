import 'dart:convert';
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

  factory MoveModel.fromJson(Map<String, dynamic> json) {
    return MoveModel(
      cellPosition:
          CellPositionModel.fromJson(jsonDecode(json['cellPosition'])),
      value: int.parse(json['value']!),
      oldValue: int.parse(json['oldValue']!),
      notes: List<int>.from(jsonDecode(json['notes'])),
      oldNotes: List<int>.from(jsonDecode(json['oldNotes'])),
    );
  }

  Map<String, String> toJson() => {
        'cellPosition': jsonEncode(cellPosition.toJson()),
        'value': '$value',
        'oldValue': '$oldValue',
        'notes': jsonEncode(notes),
        'oldNotes': jsonEncode(oldNotes),
      };
}
