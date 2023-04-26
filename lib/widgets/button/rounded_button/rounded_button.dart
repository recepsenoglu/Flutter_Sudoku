import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.buttonText,
    required this.onPressed,
    this.icon,
    this.disabled = false,
    this.whiteButton = false,
    super.key,
  });

  final String buttonText;
  final Function() onPressed;
  final IconData? icon;
  final bool disabled;
  final bool whiteButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: !disabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              !whiteButton ? AppColors.roundedButton : AppColors.buttonText,
          disabledBackgroundColor: AppColors.buttonDisabled,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 0,
          foregroundColor: !whiteButton
              ? AppColors.buttonText
              : AppColors.whiteButtonForeground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: getTextStyle(),
            ),
            if (icon != null) ...[
              const SizedBox(width: 11),
              Icon(
                icon,
                color: getIconColor(),
              )
            ],
          ],
        ),
      ),
    );
  }

  TextStyle getTextStyle() {
    if (disabled) {
      return AppTextStyles.disabledButtonText;
    } else if (whiteButton) {
      return AppTextStyles.whiteButtonText;
    }
    return AppTextStyles.buttonText;
  }

  Color getIconColor() {
    if (disabled) {
      return AppColors.buttonDisabledText;
    } else if (whiteButton) {
      return AppColors.roundedButton;
    }
    return AppColors.buttonText;
  }
}
