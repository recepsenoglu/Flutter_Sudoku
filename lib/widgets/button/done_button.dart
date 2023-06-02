import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/services/routes.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => Routes.back(),
      child: Text(
        Strings.done,
        style: AppTextStyles.doneButtonText,
      ),
    );
  }
}
