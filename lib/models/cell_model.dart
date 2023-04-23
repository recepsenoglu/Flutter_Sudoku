import 'package:flutter_sudoku/models/cell_position_model.dart';

class CellModel {
  int? value;
  final int realValue;
  final bool isGivenNumber;
  bool isSelected;
  bool isHighlighted;
  bool isNoteCell;
  final List<int> notes;
  final CellPositionModel position;

  CellModel({
    this.value,
    required this.realValue,
    required this.position,
    required this.isGivenNumber,
    this.isSelected = false,
    this.isHighlighted = false,
    this.isNoteCell = false,
    this.notes = const [],
  });

  bool get hasValue => value != null;

  bool get isValueCorrect => value == realValue;

  bool notesContains(int number) => notes.contains(number);

  List<String> stringNotes() => List<String>.from(notes);

  String print() => isGivenNumber
      ? realValue.toString()
      : hasValue
          ? value.toString()
          : 'a';
}
