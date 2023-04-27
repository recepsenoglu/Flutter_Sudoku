import 'package:flutter_sudoku/constant/enums.dart';

class GameSettings {
  static int amountOfNumbersGiven(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.Easy:
        return 38;
      case Difficulty.Medium:
        return 30;
      case Difficulty.Hard:
        return 28;
      case Difficulty.Expert:
        return 26;
      case Difficulty.Nightmare:
        return 22;
      default:
        return 30;
    }
  }
}
