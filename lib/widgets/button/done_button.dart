import 'package:flutter/material.dart';

import '../../services/game_routes.dart';
import '../../utils/game_sizes.dart';
import '../../utils/game_strings.dart';
import '../../utils/game_text_styles.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => GameRoutes.back(),
      child: Text(
        GameStrings.done,
        style: GameTextStyles.doneButtonText.copyWith(
          fontSize: GameSizes.getWidth(0.04),
        )
      ),
    );
  }
}
