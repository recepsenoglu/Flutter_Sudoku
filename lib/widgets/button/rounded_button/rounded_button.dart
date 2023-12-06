import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/app_text_styles.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';

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
    this.textSize,
    this.subTextSize,
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
  final double? textSize;
  final double? subTextSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: !disabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            !whiteButton ? AppColors.roundedButton : AppColors.buttonText,
        disabledBackgroundColor: AppColors.buttonDisabled,
        padding: GameSizes.getSymmetricPadding(0.02, 0.0015),
        maximumSize: Size(double.infinity, GameSizes.getHeight(0.07)),
        shape: RoundedRectangleBorder(borderRadius: GameSizes.getRadius(28)),
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
                  SizedBox(height: GameSizes.getHeight(0.005)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (subIcon != null) ...[
                        Padding(
                          padding:
                              EdgeInsets.only(right: GameSizes.getWidth(0.015)),
                          child: Icon(
                            subIcon,
                            color: getIconColor(),
                            size: GameSizes.getHeight(0.02),
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
              SizedBox(width: GameSizes.getWidth(0.02)),
              Icon(
                icon,
                color: getIconColor(),
                size: GameSizes.getHeight(0.03),
              )
            ],
          ],
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
        ? textStyle.copyWith(fontSize: textSize ?? GameSizes.getHeight(0.022))
        : AppTextStyles.buttonSubText.copyWith(
            color: textStyle.color,
            fontSize: subTextSize ?? GameSizes.getHeight(0.015));
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
