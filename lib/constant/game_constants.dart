import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/models/board_model.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/models/cell_position_model.dart';

class GameSettings {
  static BoardModel createSudokuBoard() {
    List<List<CellModel>> cells = List.generate(
        9,
        (y) => List.generate(
            9,
            (x) => CellModel(
                  position: CellPositionModel(y: y, x: x),
                  realValue: 0,
                  notes: [],
                )));

    return BoardModel(cells: cells, movesLog: []);
  }

  static List<StatisticType> get getStatisticTypes => [
        StatisticType.Games,
        StatisticType.Time,
        StatisticType.Score,
        StatisticType.Streaks
      ];

  static List<Difficulty> get getDifficulties => [
        Difficulty.Easy,
        Difficulty.Medium,
        Difficulty.Hard,
        Difficulty.Expert,
        Difficulty.Nightmare
      ];

  static List<TimeInterval> get getTimeIntervals => [
        TimeInterval.Today,
        TimeInterval.This_week,
        TimeInterval.This_month,
        TimeInterval.This_year,
        TimeInterval.All_time,
      ];

  static int amountOfNumbersGiven(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.Easy:
        return 38;
      case Difficulty.Medium:
        return 30;
      case Difficulty.Hard:
        return 28;
      case Difficulty.Expert:
        return 22;
      case Difficulty.Nightmare:
        return 23;
      default:
        return 30;
    }
  }
}
