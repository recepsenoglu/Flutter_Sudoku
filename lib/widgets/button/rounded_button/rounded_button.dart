import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.buttonText,
    required this.onPressed,
    this.icon,
    this.subText,
    this.subIcon,
    this.disabled = false,
    this.whiteButton = false,
    this.elevation = 0,
    super.key,
  });

  final String buttonText;
  final Function() onPressed;
  final String? subText;
  final IconData? subIcon;
  final IconData? icon;
  final bool disabled;
  final bool whiteButton;
  final double elevation;

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
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          maximumSize: const Size(double.infinity, 58),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: elevation,
          foregroundColor: !whiteButton
              ? AppColors.buttonText
              : AppColors.whiteButtonForeground,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buttonText,
                    style: getTextStyle(),
                  ),
                  if (subIcon != null || subText != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (subIcon != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              subIcon,
                              color: getIconColor(),
                              size: 16,
                            ),
                          ),
                        ],
                        if (subText != null) ...[
                          Text(
                            subText!,
                            style: getTextStyle(subText: true),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
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
      ),
    );
  }

  TextStyle getTextStyle({bool subText = false}) {
    TextStyle textStyle;
    if (disabled) {
      textStyle = AppTextStyles.disabledButtonText;
    } else if (whiteButton) {
      textStyle = AppTextStyles.whiteButtonText;
    } else {
      textStyle = AppTextStyles.buttonText;
    }

    return !subText
        ? textStyle
        : AppTextStyles.buttonSubText.copyWith(color: textStyle.color);
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
