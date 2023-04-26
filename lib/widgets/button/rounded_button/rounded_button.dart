import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.buttonText,
    required this.onPressed,
    super.key,
  });

  final String buttonText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.roundedButton,
          disabledBackgroundColor: AppColors.buttonDisabled,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: Text(
          buttonText,
          style: AppTextStyles.buttonText,
        ),
      ),
    );
  }
}
