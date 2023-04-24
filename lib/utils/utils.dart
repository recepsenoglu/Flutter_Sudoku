import 'package:flutter/material.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

Color getCellColor(CellModel cell, CellModel selectedCell) {
  if (cell.position == selectedCell.position) {
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
