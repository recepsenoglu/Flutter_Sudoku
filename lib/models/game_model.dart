import 'dart:convert';

import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/constant/game_constants.dart';
import 'package:flutter_sudoku/models/board_model.dart';

class GameModel {
  BoardModel sudokuBoard;
  Difficulty difficulty;
  int mistakes;
  int score;
  int time;
  int hints;

  GameModel({
    required this.difficulty,
    required this.sudokuBoard,
    this.mistakes = 0,
    this.score = 0,
    this.time = 0,
    this.hints = 3,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      sudokuBoard: BoardModel.fromJson(jsonDecode(json['sudokuBoard'])),
      difficulty: getDifficulty(json['difficulty']!),
      mistakes: int.parse(json['mistakes']!),
      score: int.parse(json['score']!),
      time: int.parse(json['time']!),
      hints: int.parse(json['hints']!),
    );
  }

  Map<String, String> toJson() => {
        'sudokuBoard': jsonEncode(sudokuBoard.toJson()),
        'difficulty': difficulty.name,
        'mistakes': '$mistakes',
        'score': '$score',
        'time': '$time',
        'hints': '$hints',
      };

  static Difficulty getDifficulty(String difficulty) {
    return GameSettings.getDifficulties
        .firstWhere((element) => element.name == difficulty);
  }

  bool get isOnGoingGame => time > 0;
}
