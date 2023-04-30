import 'package:flutter_sudoku/constant/enums.dart';

class GameSettings {
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
