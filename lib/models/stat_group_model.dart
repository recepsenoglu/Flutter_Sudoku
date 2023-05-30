import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/models/stat_model.dart';

class StatGroupModel {
  final Difficulty difficulty;
  final List<StatModel> stats;

  StatGroupModel({
    required this.difficulty,
    required this.stats,
  });

  void sortStats() {
    stats.sort((a, b) => a.index.compareTo(b.index));
  }

  List<StatModel> getStats(StatisticType statisticType) {
    return stats.where((stat) => stat.type == statisticType).toList();
  }
}
