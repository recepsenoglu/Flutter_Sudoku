import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/constant/game_constants.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/models/cell_position_model.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

int generateRandomNumber({required Set<int> exclude}) {
  List<int> numberList = List<int>.from([1, 2, 3, 4, 5, 6, 7, 8, 9]);

  numberList.removeWhere((element) => exclude.contains(element));

  numberList.shuffle();

  return numberList.first;
}

CellPositionModel generateRandomPosition() {
  List<int> numbers = List<int>.from([0, 1, 2, 3, 4, 5, 6, 7, 8]);

  numbers.shuffle();
  final int y = numbers.first;
  numbers.shuffle();
  final int x = numbers.first;

  return CellPositionModel(y: y, x: x);
}

Set<CellPositionModel> getRandomPositions(Difficulty difficulty) {
  final Set<CellPositionModel> cellPositions = {};

  final int amount = GameSettings.amountOfNumbersGiven(difficulty);

  while (cellPositions.length != amount) {
    cellPositions.add(generateRandomPosition());
  }
  return cellPositions;
}

Color getCellColor({
  required CellModel cell,
  required CellModel selectedCell,
  required bool hideCells,
}) {
  if (hideCells) {
    return AppColors.cell;
  } else if (cell.position == selectedCell.position) {
    return AppColors.selectedCell;
  } else if (cell.hasValue && !cell.isValueCorrect && !cell.isGivenNumber) {
    return AppColors.wrongNumberCell;
  } else if (!cell.isHighlighted) {
    return AppColors.cell;
  } else {
    if (cell.hasValue && cell.value == selectedCell.value) {
      if (!selectedCell.isValueCorrect &&
          cell.hasIntersectionWith(selectedCell.position)) {
        return AppColors.wrongNumberCell;
      } else {
        return AppColors.highlightedNumberCell;
      }
    } else {
      return AppColors.highlightedCell;
    }
  }
}

TextStyle? getStyle(CellModel cell) {
  if (cell.hasValue) {
    if (cell.isGivenNumber) {
      return AppTextStyles.givenNumber;
    } else if (cell.isValueCorrect) {
      return AppTextStyles.enteredNumber;
    } else {
      return AppTextStyles.wrongNumber;
    }
  }
  return null;
}
