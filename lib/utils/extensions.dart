import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/constant/game_constants.dart';

extension TimeString on int {
  String toTimeString() {
    if (this >= 0) {
      final int minutes = (this / 60).floor();
      final int seconds = this - 60 * minutes;

      return '${minutes < 10 ? '0' : ''}$minutes:${seconds < 10 ? '0' : ''}$seconds';
    }
    return '-- : --';
  }
}

extension StringExtensions on String {
  bool toBool() {
    return this == 'true';
  }

  Difficulty toDifficulty() {
    return GameSettings.getDifficulties
        .firstWhere((element) => element.name == this);
  }
}
