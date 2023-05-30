import 'dart:convert';

import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/models/game_model.dart';
import 'package:flutter_sudoku/models/game_stats_model.dart';
import 'package:flutter_sudoku/models/statistics_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;

  StorageService._create();

  static Future<StorageService> initialize() async {
    StorageService storageService = StorageService._create();
    storageService._prefs = await SharedPreferences.getInstance();
    return storageService;
  }

  Future<void> saveGame(GameModel gameModel) async {
    await _prefs.setString('game', jsonEncode(gameModel.toJson()));
  }

  GameModel? getSavedGame() {
    if (_prefs.containsKey('game')) {
      String jsonString = _prefs.getString('game')!;

      return GameModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  Future<void> saveGameStats(GameStatsModel gameStatsModel) async {
    StatisticsModel? statistics = getStatistics(gameStatsModel.difficulty);
    statistics ??= StatisticsModel(statistics: [], statGroups: []);

    if (statistics.statistics.isEmpty || gameStatsModel.isOnGoing) {
      statistics.statistics.add(gameStatsModel);
    } else {
      statistics.updateLast(gameStatsModel);
    }

    await _prefs.setString('statistics_${gameStatsModel.difficulty}',
        jsonEncode(statistics.toJson()));
  }

  StatisticsModel? getStatistics(Difficulty difficulty) {
    if (_prefs.containsKey('statistics_$difficulty')) {
      String jsonString = _prefs.getString('statistics_$difficulty')!;

      return StatisticsModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }
}
