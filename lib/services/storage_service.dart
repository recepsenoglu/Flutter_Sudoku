import 'dart:convert';

import 'package:flutter_sudoku/models/game_model.dart';
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
}
