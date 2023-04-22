import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

class GameInfoWidget extends StatelessWidget {
  const GameInfoWidget({
    required this.title,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    super.key,
  });

  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: AppTextStyles.gameInfoTitle,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.gameInfoValue,
        ),
      ],
    );
  }
}
