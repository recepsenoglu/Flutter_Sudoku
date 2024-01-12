import 'package:flutter/material.dart';

import '../../utils/game_routes.dart';
import '../../utils/game_sizes.dart';
import '../../utils/game_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => GameRoutes.back(),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: Text(
        text,
        style: GameTextStyles.customTextButtonText.copyWith(
          fontSize: GameSizes.getWidth(0.038),
        ),
      ),
    );
  }
}
