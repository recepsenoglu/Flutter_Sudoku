import 'package:flutter_sudoku/models/cell_position_model.dart';

class CellModel {
  int? value;
  final int realValue;
  final bool isGivenNumber;
  bool isNoteCell;
  final List<int> notes;
  final CellPositionModel position;

  CellModel({
    this.value,
    required this.realValue,
    required this.isGivenNumber,
    required this.isNoteCell,
    required this.notes,
    required this.position,
  });

  bool get hasValue => value != null;

  bool get isValueCorrect => value == realValue;

  List<String> stringNotes() => List<String>.from(notes);

  String print() => isGivenNumber ? realValue.toString() : value != null ? value.toString() : ' ';
}
