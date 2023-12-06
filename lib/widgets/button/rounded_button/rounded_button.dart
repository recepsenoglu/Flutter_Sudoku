import 'package:flutter/material.dart';

import '../../../utils/exports.dart';

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
            !whiteButton ? GameColors.roundedButton : GameColors.buttonText,
        disabledBackgroundColor: GameColors.buttonDisabled,
        padding: GameSizes.getSymmetricPadding(0.02, 0.0015),
        maximumSize: Size(double.infinity, GameSizes.getHeight(0.07)),
        shape: RoundedRectangleBorder(borderRadius: GameSizes.getRadius(32)),
        elevation: elevation,
        foregroundColor: !whiteButton
            ? GameColors.buttonText
            : GameColors.whiteButtonForeground,
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
                size: GameSizes.getWidth(0.06),
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
      textStyle = GameTextStyles.disabledButtonText;
    } else if (whiteButton) {
      textStyle = GameTextStyles.whiteButtonText;
    } else {
      textStyle = GameTextStyles.buttonText;
    }

    return !subText
        ? textStyle.copyWith(fontSize: textSize ?? GameSizes.getWidth(0.045))
        : GameTextStyles.buttonSubText.copyWith(
            color: textStyle.color,
            fontSize: subTextSize ?? GameSizes.getHeight(0.015));
  }

  Color getIconColor() {
    if (disabled) {
      return GameColors.buttonDisabledText;
    } else if (whiteButton) {
      return GameColors.roundedButton;
    }
    return GameColors.buttonText;
  }
}
