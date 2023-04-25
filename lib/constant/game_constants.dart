import 'package:flutter_sudoku/constant/enums.dart';

class GameSettings {
  static int amountOfNumbersGiven(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.Easy:
        return 38;
      case Difficulty.medium:
        return 30;
      case Difficulty.hard:
        return 28;
      default:
        return 30;
    }
  }
}
