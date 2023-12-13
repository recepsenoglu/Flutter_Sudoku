import 'dart:convert';

import 'package:flutter_sudoku/models/cell_position_model.dart';
import 'package:flutter_sudoku/utils/extensions.dart';

class CellModel {
  int value;
  int realValue;
  bool isGivenNumber;
  bool isHighlighted;
  bool scored = false;
  List<int> notes;
  final CellPositionModel position;

  CellModel({
    this.value = 0,
    required this.realValue,
    required this.position,
    this.isGivenNumber = false,
    this.isHighlighted = false,
    required this.notes,
  });

  bool get hasValue => value != 0;

  bool get hasRealValue => realValue != 0;

  bool get isValueCorrect => hasValue && value == realValue;

  bool get hasNotes => notes.isNotEmpty;

  bool hasIntersectionWith(CellPositionModel cellPosition) =>
      position.x == cellPosition.x ||
      position.y == cellPosition.y ||
      position.boxIndex == cellPosition.boxIndex;

  bool notesContains(int number) => notes.contains(number);

  List<String> stringNotes() => List<String>.from(notes);

  String print() => isGivenNumber
      ? realValue.toString()
      : hasValue
          ? value.toString()
          : ' ';

  factory CellModel.fromJson(Map<String, dynamic> json) {
    return CellModel(
      value: int.parse(json['value']!),
      realValue: int.parse(json['realValue']!),
      isGivenNumber: (json['isGivenNumber']!).toString().toBool(),
      isHighlighted: (json['isHighlighted']!).toString().toBool(),
      position: CellPositionModel.fromJson(jsonDecode(json['position'])),
      notes: List<int>.from(jsonDecode(json['notes'])),
    );
  }

  Map<String, String> toJson() => {
        'value': '$value',
        'realValue': '$realValue',
        'isGivenNumber': '$isGivenNumber',
        'isHighlighted': '$isHighlighted',
        'notes': jsonEncode(notes),
        'position': jsonEncode(position.toJson()),
      };
}
