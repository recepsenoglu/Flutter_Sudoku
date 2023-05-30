import 'dart:convert';

import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/models/game_stats_model.dart';
import 'package:flutter_sudoku/models/stat_group_model.dart';

class StatisticsModel {
  List<GameStatsModel> statistics;
  List<StatGroupModel> statGroups;

  StatisticsModel({
    required this.statistics,
    required this.statGroups,
  });

  List<StatGroupModel> getStatGroups(Difficulty difficulty) {
    return statGroups
        .where((gameStats) => gameStats.difficulty == difficulty)
        .toList();
  }

  void updateLast(GameStatsModel gameStatsModel) {
    statistics.sort((a, b) => a.startTime.compareTo(b.startTime));

    statistics.last = gameStatsModel;
  }

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      statistics: List<GameStatsModel>.from(
        jsonDecode(json['statistics']).map((e) => GameStatsModel.fromJson(e)),
      ),
      statGroups: [],
    );
  }

  Map<String, String> toJson() => {
        'statistics': jsonEncode(statistics.map((e) => e.toJson()).toList()),
      };
}
