import 'package:flutter/material.dart';
import 'package:flutter_sudoku/models/cell_model.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

Color getCellColor(CellModel cell, CellModel selectedCell) {
  if (cell.isSelected) {
    return AppColors.selectedCell;
  } else if (cell.hasValue && !cell.isValueCorrect && !cell.isGivenNumber) {
    return AppColors.wrongNumberCell;
  } else if (cell.isHighlighted) {
    if (cell.hasValue && cell.value == selectedCell.value) {
      return AppColors.highlightedNumberCell;
    } else {
      return AppColors.highlightedCell;
    }
  } else {
    return AppColors.cell;
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
