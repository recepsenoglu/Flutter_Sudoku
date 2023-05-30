import 'package:flutter_sudoku/constant/enums.dart';

class StatModel {
  final int index;
  final dynamic value;
  final String title;
  final StatisticType type;

  StatModel({
    required this.index,
    required this.value,
    required this.title,
    required this.type,
  });
}
