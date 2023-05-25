import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/utils/extensions.dart';

class GameStatsModel {
  final DateTime dateTime;
  final DateTime startTime;
  final Difficulty difficulty;
  final bool? won;
  final int? score;
  final int? time;

  GameStatsModel({
    required this.dateTime,
    required this.startTime,
    required this.difficulty,
    this.won,
    this.score,
    this.time,
  });

  bool get isOnGoing => won == null;

  factory GameStatsModel.fromJson(Map<String, dynamic> json) {
    return GameStatsModel(
      dateTime: DateTime.parse(json['dateTime']),
      startTime: DateTime.parse(json['startTime']),
      difficulty: json['difficulty'].toString().toDifficulty(),
      won: json['won'] != 'null' ? json['won'].toString().toBool() : null,
      score: json['score'] != 'null' ? int.parse(json['score']!) : null,
      time: json['time'] != 'null' ? int.parse(json['time']!) : null,
    );
  }

  Map<String, String> toJson() => {
        'dateTime': dateTime.toString(),
        'startTime': startTime.toString(),
        'difficulty': difficulty.name,
        'won': '$won',
        'score': '$score',
        'time': '$time',
      };

  @override
  String toString() => toJson().toString();
}
